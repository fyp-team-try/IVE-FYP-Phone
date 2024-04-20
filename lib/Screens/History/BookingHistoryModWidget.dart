import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Models/Api/RequestModels/EditReservationRequestModel.dart';
import 'package:user_app/Models/ReservationRecorrdInfo.dart';
import 'package:user_app/Providers/AuthProvider.dart';
import 'package:user_app/Services/request/CancelReservationRequest.dart';
import 'package:user_app/Services/request/EditReservationRequest.dart';
import 'BookingHistoryModModel.dart';
export 'BookingHistoryModModel.dart';

class HistoryModifybookingWidget extends StatefulWidget {
  const HistoryModifybookingWidget({super.key});

  @override
  State<HistoryModifybookingWidget> createState() =>
      _HistoryModifybookingWidgetState();
}

class _HistoryModifybookingWidgetState
    extends State<HistoryModifybookingWidget> {
  late HistoryModifybookingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  BookingRecordInfo? reservationObject;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryModifybookingModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void editReservation() async {
    int reservationID = reservationObject!.reservationID;
    DateTime sTime = reservationObject!.startTime;
    DateTime eTime = reservationObject!.endTime;

    DateTime? startDate = _model.datePicked1??DateTime(sTime.year,sTime.month,sTime.day);
    TimeOfDay? startTime = _model.pickerTimeValue1??TimeOfDay(hour: sTime.hour, minute: sTime.minute);
    DateTime? endDate = _model.datePicked2??DateTime(eTime.year,eTime.month,eTime.day);
    TimeOfDay? endTime = _model.pickerTimeValue2??TimeOfDay(hour: eTime.hour, minute: eTime.minute);
    String? spaceType = _model.dropDownValue3??reservationObject!.spaceType;

    String token = context.read<AuthProvider>().getUserInfo().token;


      try {
        EditReservationRequestModel editReservationRequestModel =
            EditReservationRequestModel(
                reservationID: reservationObject!.reservationID,
                startTime: DateTime(startDate.year,startDate.month,startDate.day,startTime.hour,startTime.minute).toIso8601String(), 
                endTime: DateTime(endDate.year,endDate.month,endDate.day,endTime.hour,endTime.minute).toIso8601String(), 
                spaceType: spaceType
            );

            
        bool isRegSuccess = await editReservationRequest(editReservationRequestModel, context, token);

        if (isRegSuccess) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Edit Successful'),
                content: Text('You have Edit the reservation.'),
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
          Navigator.pop(context);
        }
      } catch (e) {

      }
  }

    void cancelReservation() async {
    int reservationID = reservationObject!.reservationID;
    DateTime sTime = reservationObject!.startTime;
    DateTime eTime = reservationObject!.endTime;

    DateTime? startDate = _model.datePicked1??DateTime(sTime.year,sTime.month,sTime.day);
    TimeOfDay? startTime = _model.pickerTimeValue1??TimeOfDay(hour: sTime.hour, minute: sTime.minute);
    DateTime? endDate = _model.datePicked2??DateTime(eTime.year,eTime.month,eTime.day);
    TimeOfDay? endTime = _model.pickerTimeValue2??TimeOfDay(hour: eTime.hour, minute: eTime.minute);
    String? spaceType = _model.dropDownValue3??reservationObject!.spaceType;

    String token = context.read<AuthProvider>().getUserInfo().token;


      try {
        EditReservationRequestModel editReservationRequestModel =
            EditReservationRequestModel(
                reservationID: reservationObject!.reservationID,
                startTime: DateTime(startDate.year,startDate.month,startDate.day,startTime.hour,startTime.minute).toIso8601String(), 
                endTime: DateTime(endDate.year,endDate.month,endDate.day,endTime.hour,endTime.minute).toIso8601String(), 
                spaceType: spaceType
            );

            
        bool isRegSuccess = await CancelReservationRequest(editReservationRequestModel, context, token);

        if (isRegSuccess) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Cancel Successful'),
                content: Text('You have cancel the reservation.'),
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
          Navigator.pop(context);
        }
      } catch (e) {

      }
  }

  @override
  Widget build(BuildContext context) {
    reservationObject =
        ModalRoute.of(context)!.settings.arguments as BookingRecordInfo;
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Modify Booking',
            style: FlutterFlowTheme.of(context).headlineLarge,
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 30, 20, 0),
                child: Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Car plate :',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                              FlutterFlowDropDown(
                                initialOption:
                                    reservationObject!.vehicleLicense,
                                options: [reservationObject!.vehicleLicense],
                                onChanged: (val) =>
                                    setState(() => _model.dropDownValue2 = val),
                                width: 185,
                                height: 40,
                                textStyle:
                                    FlutterFlowTheme.of(context).bodyMedium,
                                hintText: 'Select car plate',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2,
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                borderWidth: 2,
                                borderRadius: 8,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    16, 4, 16, 4),
                                hidesUnderline: true,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Start Time :',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                          context: context,
                                          initialDate:
                                              _model.datePicked1 ??reservationObject!.startTime,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(
                                              DateTime.now().year + 1,
                                              DateTime.now().month,
                                              DateTime.now().day));
                                  final TimeOfDay? pickedTime =
                                      await showTimePicker(
                                          context: context,
                                          initialTime:
                                              _model.pickerTimeValue1 ??TimeOfDay(hour: reservationObject!.startTime.hour, minute: reservationObject!.startTime.minute));

                                  if (pickedDate != null &&
                                      pickedTime != null) {
                                    setState(() {
                                      _model.datePicked1 = pickedDate;
                                      _model.pickerTimeValue1 = pickedTime;
                                    });
                                  } else {
                                    setState(() {
                                      _model.datePicked1 = null;
                                      _model.pickerTimeValue1 = null;
                                    });
                                  }
                                },
                                text: _model.datePicked1 != null
                                    ? '${_model.datePicked1?.day}/${_model.datePicked1?.month}/${_model.datePicked1?.year} ${_model.pickerTimeValue1?.hour.toString().padLeft(2, '0')}:${_model.pickerTimeValue1?.minute.toString().padLeft(2, '0')}'
                                    : '${reservationObject!.startTime.day}/${reservationObject!.startTime.month}/${reservationObject!.startTime.year} ${reservationObject!.startTime.hour.toString().padLeft(2, '0')}:${reservationObject!.startTime.minute.toString().padLeft(2, '0')}',
                                options: FFButtonOptions(
                                  width: 185,
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 24, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).info,
                                  textStyle:
                                      FlutterFlowTheme.of(context).bodySmall,
                                  elevation: 3,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'EndTime :',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  final DateTime? pickedDate2 =
                                      await showDatePicker(
                                          context: context,
                                          initialDate: _model.datePicked2 ??
                                              reservationObject!.endTime,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(
                                              DateTime.now().year + 1,
                                              DateTime.now().month,
                                              DateTime.now().day));
                                  final TimeOfDay? pickedTime2 =
                                      await showTimePicker(
                                          context: context,
                                          initialTime:
                                              _model.pickerTimeValue2 ??
                                                  TimeOfDay(hour: reservationObject!.endTime.hour, minute: reservationObject!.endTime.minute));

                                  if (pickedDate2 != null &&
                                      pickedTime2 != null) {
                                    setState(() {
                                      _model.datePicked2 = pickedDate2;
                                      _model.pickerTimeValue2 = pickedTime2;
                                    });
                                  } else {
                                    setState(() {
                                      _model.datePicked2 = null;
                                      _model.pickerTimeValue2 = null;
                                    });
                                  }
                                },
                                text: _model.datePicked2 != null
                                    ? '${_model.datePicked2?.day}/${_model.datePicked2?.month}/${_model.datePicked2?.year} ${_model.pickerTimeValue2?.hour.toString().padLeft(2, '0')}:${_model.pickerTimeValue2?.minute.toString().padLeft(2, '0')}'
                                    : '${reservationObject!.endTime.day}/${reservationObject!.endTime.month}/${reservationObject!.endTime.year} ${reservationObject!.endTime.hour.toString().padLeft(2, '0')}:${reservationObject!.endTime.minute.toString().padLeft(2, '0')}',
                                options: FFButtonOptions(
                                  width: 185,
                                  height: 40,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 24, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).info,
                                  textStyle:
                                      FlutterFlowTheme.of(context).bodySmall,
                                  elevation: 3,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Car lot type :',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                              FlutterFlowDropDown(
                                initialOption: reservationObject!.spaceType,
                                options: ["REGULAR","ELECTRIC"],
                                onChanged: (val) =>
                                    setState(() => _model.dropDownValue3 = val),
                                width: 185,
                                height: 40,
                                textStyle:
                                    FlutterFlowTheme.of(context).bodyMedium,
                                hintText: 'Please select car plate',
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2,
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                borderWidth: 2,
                                borderRadius: 8,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    16, 4, 16, 4),
                                hidesUnderline: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    editReservation();
                  },
                  text: 'Submit',
                  options: FFButtonOptions(
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primaryText,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    cancelReservation();
                  },
                  text: 'Cancel reservation ',
                  options: FFButtonOptions(
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primaryText,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
            ],
          ),
        ),
      ),
    );
  }
}
