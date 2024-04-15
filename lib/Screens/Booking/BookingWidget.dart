import 'dart:convert';

import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Models/Api/ApiResponse.dart';
import 'package:user_app/Models/Api/RequestModels/ReservationRequestModel.dart';
import 'package:user_app/Models/Api/ResponseModels/ParkingLotInfo.dart';
import 'package:user_app/Models/Api/ResponseModels/ParkingLotPrices.dart';
import 'package:user_app/Models/VehicleInfo.dart';
import 'package:user_app/Models/MyInfo.dart';
import 'package:user_app/Providers/AuthProvider.dart';
import 'package:user_app/Services/ApiRequest.dart';
import 'package:user_app/Services/request/ReservationRequest.dart';

import 'BookingModel.dart';
export 'BookingModel.dart';

class BookingWidget extends StatefulWidget {
  const BookingWidget({super.key, required this.parkingLotInfo});
  final ParkingLotInfo parkingLotInfo;

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  late BookingModel _model;
  List<VehicleInfo>? vehicleInfoList;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<ParkingLotPrices> regPricingList, elecPricingList;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookingModel());
    regPricingList =widget.parkingLotInfo.regularSpacePrices;
    elecPricingList =widget.parkingLotInfo.electricSpacePrices;
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {});
    GetVehicleInfo(context);
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void GetVehicleInfo(BuildContext context) async {
    print('GetVehicleInfo()');
    try {
      ApiRequest api = new ApiRequest();

      String token = context.read<AuthProvider>().getUserInfo().token;
      ApiResponse<MyInfo> response = await api.get(
          'me', (json) => MyInfo.fromJson(json as Map<String, dynamic>), token);

      ApiResponse<List<VehicleInfo>> response2 = await api.get(
          'users/${response.data?.userID}/vehicles',
          (json) => (json as List<dynamic>).map<VehicleInfo>((dynamic item) {
                return VehicleInfo.fromJson(item);
              }).toList(),
          token);

      if (response2.statusCode == 200) {
        setState(() => vehicleInfoList = response2.data);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data Fetch failed'),
          duration: Duration(seconds: 5),
        ));
      }
    } catch (ex) {
      return null;
    }
  }

  double calculatePrice(
      List<ParkingLotPrices> priceList, DateTime startDate, DateTime endDate) {
    int remainingDuration = endDate.difference(startDate).inHours;
    int currentHour = startDate.hour;
    double totalPrice = 0;

    while (remainingDuration > 0) {
      totalPrice += priceList[currentHour].price;
      currentHour = (currentHour + 1) % 24;
      remainingDuration--;
    }

    return totalPrice;
  }

  List<int> getPricingListByString(String s) {
    String jsonString = s;
    jsonString = jsonString.replaceAll('time', '"time"');
    jsonString = jsonString.replaceAll('price', '"price"');
    jsonString = jsonString.replaceAllMapped(
        RegExp(r'(\d{2}:\d{2})'), (match) => '"${match.group(0)}"');
    List<dynamic> jsonData = jsonDecode(jsonString);

    List<int> prices =
        jsonData.map<int>((item) => item['price'].toInt()).toList();

    return prices;
  }

  void createReservation() async {
    int? vehicleID = vehicleInfoList
        ?.where((vehicle) => vehicle.vehicleLicense == _model.dropDownValue2)
        .firstOrNull
        ?.vehicleID;
    int lotID = widget.parkingLotInfo.lotID;
    DateTime? startDate = _model.pickerDateValue1;
    TimeOfDay? startTime = _model.pickerTimeValue1;
    DateTime? endDate = _model.pickerDateValue2;
    TimeOfDay? endTime = _model.pickerTimeValue2;
    String? spaceType = _model.dropDownValue3;

    bool inputsNotNull = vehicleID != null &&
        startDate != null &&
        startTime != null &&
        endDate != null &&
        endTime != null &&
        spaceType != null;

    String token = context.read<AuthProvider>().getUserInfo().token;

    if (inputsNotNull) {
      try {
        ReservationRequestModel reservationRequestModel =
            ReservationRequestModel(
                vehicleID: vehicleID,
                lotID: lotID,
                startTime: DateTime(startDate.year, startDate.month,
                        startDate.day, startTime.hour, startTime.minute)
                    .toIso8601String(),
                endTime: DateTime(endDate.year, endDate.month, endDate.day,
                        endTime.hour, endTime.minute)
                    .toIso8601String(),
                spaceType: spaceType.toUpperCase());

        bool isRegSuccess = await createReservationRequest(
            reservationRequestModel, context, token);

        if (isRegSuccess) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Reservation Successful'),
                content: Text('You have reserved a spot.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
          Navigator.pushNamed(context, '/locationDetail',
              arguments: widget.parkingLotInfo.lotID);
        }
      } catch (e) {}
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error '),
            content: Text('Please select all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ParkingLotInfo parkingLotInfo = widget.parkingLotInfo;
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reservation',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ].divide(SizedBox(height: 4)),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: 770,
                            ),
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Please fill out the form below to continue.',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: Container(
                                        width: 357,
                                        height: 71,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(-1, 0),
                                              child: Text(
                                                'Parking Lot :',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 20,
                                                        ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: FlutterFlowDropDown(
                                                options: [parkingLotInfo.name],
                                                onChanged: (val) => setState(
                                                    () => _model
                                                        .dropDownValue1 = val),
                                                width: 186,
                                                height: 50,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                                hintText: 'Select car lot',
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 24,
                                                ),
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                elevation: 2,
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                borderWidth: 2,
                                                borderRadius: 8,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(16, 4, 16, 4),
                                                hidesUnderline: true,
                                                initialOption:
                                                    parkingLotInfo.name,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: Container(
                                        width: 357,
                                        height: 71,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(-1, 0),
                                              child: Text(
                                                'Car Plate :',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 20,
                                                        ),
                                              ),
                                            ),
                                            Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: FlutterFlowDropDown(
                                                  options: vehicleInfoList !=
                                                          null
                                                      ? vehicleInfoList!
                                                          .map((vehicle) =>
                                                              vehicle
                                                                  .vehicleLicense)
                                                          .toList()
                                                      : [],
                                                  onChanged: (val) => setState(
                                                      () => _model
                                                              .dropDownValue2 =
                                                          val),
                                                  width: 186,
                                                  height: 50,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium,
                                                  hintText: 'Select car plate',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                  borderWidth: 2,
                                                  borderRadius: 8,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(16, 4, 16, 4),
                                                  hidesUnderline: true,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: Container(
                                        width: 357,
                                        height: 71,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(-1, 0),
                                              child: Text(
                                                'Parking Space Type :',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          fontSize: 15,
                                                        ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: FlutterFlowDropDown(
                                                options: vehicleInfoList !=
                                                            null &&
                                                        vehicleInfoList!.any((vehicle) =>
                                                            vehicle.vehicleLicense ==
                                                                _model
                                                                    .dropDownValue2 &&
                                                            vehicle.vehicleType ==
                                                                1)
                                                    ? ['Regular', 'Electric']
                                                    : ['Regular'],
                                                onChanged: (val) => setState(
                                                    () => _model
                                                        .dropDownValue3 = val),
                                                width: 186,
                                                height: 50,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium,
                                                hintText: 'Select car slot',
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 24,
                                                ),
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                elevation: 2,
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                borderWidth: 2,
                                                borderRadius: 8,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(16, 4, 16, 4),
                                                hidesUnderline: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 2,
                                    thickness: 2,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Start Date',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium,
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                //Dont put anything here
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 48,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    final DateTime? pickedDate =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate: _model
                                                                    .pickerDateValue1 ??
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime.now(),
                                                            lastDate: DateTime(
                                                                DateTime
                                                                            .now()
                                                                        .year +
                                                                    1,
                                                                DateTime.now()
                                                                    .month,
                                                                DateTime.now()
                                                                    .day));
                                                    final TimeOfDay?
                                                        pickedTime =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime: _model
                                                                    .pickerTimeValue1 ??
                                                                TimeOfDay
                                                                    .now());

                                                    if (pickedDate != null &&
                                                        pickedTime != null) {
                                                      setState(() {
                                                        _model.pickerDateValue1 =
                                                            pickedDate;
                                                        _model.pickerTimeValue1 =
                                                            pickedTime;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        _model.pickerDateValue1 =
                                                            null;
                                                        _model.pickerTimeValue1 =
                                                            null;
                                                      });
                                                    }
                                                  },
                                                  text: _model.pickerDateValue1 !=
                                                          null
                                                      ? '${_model.pickerDateValue1?.day}/${_model.pickerDateValue1?.month}/${_model.pickerDateValue1?.year} ${_model.pickerTimeValue1?.hour.toString().padLeft(2, '0')}:${_model.pickerTimeValue1?.minute.toString().padLeft(2, '0')}'
                                                      : 'Select Start Time',
                                                  options: FFButtonOptions(
                                                    height: 40,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                24, 0, 24, 0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: Colors.white,
                                                        ),
                                                    elevation: 3,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 4)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'End Date',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 2,
                                                ),
                                              ),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  final DateTime? pickedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate: _model
                                                                  .pickerDateValue2 ??
                                                              DateTime.now(),
                                                          firstDate: DateTime
                                                              .now(),
                                                          lastDate:
                                                              DateTime(
                                                                  DateTime.now()
                                                                          .year +
                                                                      1,
                                                                  DateTime.now()
                                                                      .month,
                                                                  DateTime.now()
                                                                      .day));
                                                  final TimeOfDay? pickedTime =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime: _model
                                                                  .pickerTimeValue2 ??
                                                              TimeOfDay.now());

                                                  if (pickedDate != null &&
                                                      pickedTime != null) {
                                                    setState(() {
                                                      _model.pickerDateValue2 =
                                                          pickedDate;
                                                      _model.pickerTimeValue2 =
                                                          pickedTime;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _model.pickerDateValue2 =
                                                          null;
                                                      _model.pickerTimeValue2 =
                                                          null;
                                                    });
                                                  }
                                                },
                                                text: _model.pickerDateValue2 !=
                                                        null
                                                    ? '${_model.pickerDateValue2?.day}/${_model.pickerDateValue2?.month}/${_model.pickerDateValue2?.year} ${_model.pickerTimeValue2?.hour.toString().padLeft(2, '0')}:${_model.pickerTimeValue2?.minute.toString().padLeft(2, '0')}'
                                                    : 'Select Start Time',
                                                options: FFButtonOptions(
                                                  height: 40,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(24, 0, 24, 0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors.white,
                                                          ),
                                                  elevation: 3,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(height: 4)),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 12)),
                                  ),
                                ]
                                    .divide(SizedBox(height: 12))
                                    .addToEnd(SizedBox(height: 32)),
                              ),
                            ),
                          ),
                        ),
                        /*Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: Container(
                              width: 357,
                              height: 71,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      'Est. Charge:',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 25,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    '\$40',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 25,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),*/
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: Container(
                              width: 357,
                              height: 71,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      'Deposit :',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 25,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    '\$100',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 25,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: Container(
                              width: 357,
                              height: 71,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Text(
                                      'Est. Total :',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 25,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    _model.pickerDateValue1!=null&&_model.pickerTimeValue1!=null&&_model.pickerDateValue2!=null&&_model.pickerTimeValue2!=null&&_model.dropDownValue3!=null?'\$${(100 +
                                            calculatePrice(
                                                _model.dropDownValue3=="Regular"?widget.parkingLotInfo.regularSpacePrices:widget.parkingLotInfo.electricSpacePrices,
                                                DateTime(
                                                    _model
                                                        .pickerDateValue1!.year,
                                                    _model.pickerDateValue1!
                                                        .month,
                                                    _model
                                                        .pickerDateValue1!.day,
                                                    _model
                                                        .pickerTimeValue1!.hour,
                                                    0),
                                                DateTime(
                                                    _model
                                                        .pickerDateValue2!.year,
                                                    _model.pickerDateValue2!
                                                        .month,
                                                    _model
                                                        .pickerDateValue2!.day,
                                                    _model
                                                        .pickerTimeValue2!.hour,
                                                    0))).toStringAsFixed(1)}':'',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 25,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 770,
                  ),
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                    child: FFButtonWidget(
                      onPressed: () async {
                        createReservation();
                      },
                      text: 'Next',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 48,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
