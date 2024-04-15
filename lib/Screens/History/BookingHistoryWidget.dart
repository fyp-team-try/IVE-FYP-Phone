import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Components/BookingRecordItem.dart';
import 'package:user_app/Components/ParkingRecordItem.dart';
import 'package:user_app/Models/Api/ApiResponse.dart';
import 'package:user_app/Models/MyInfo.dart';
import 'package:user_app/Models/ParkingSessionInfo.dart';
import 'package:user_app/Models/ParkingSessionPageInfo.dart';
import 'package:user_app/Models/ReservationRecorrdInfo.dart';
import 'package:user_app/Providers/AuthProvider.dart';
import 'package:user_app/Services/ApiRequest.dart';

import 'BookingHistoryModel.dart';
export 'BookingHistoryModel.dart';

class BookingHistoryWidget extends StatefulWidget {
  const BookingHistoryWidget({super.key});

  @override
  State<BookingHistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<BookingHistoryWidget> {
  late BookingHistoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<BookingRecordInfo>? bookingList;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookingHistoryModel());
    GetParkingRecords();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void GetParkingRecords() async {
    try {
      ApiRequest api = ApiRequest();

      String token = context.read<AuthProvider>().getUserInfo().token;
      ApiResponse<MyInfo> idResponse = await api.get(
          'me', (json) => MyInfo.fromJson(json as Map<String, dynamic>), token);

      ApiResponse<List<BookingRecordInfo>> response = await api.get(
          'reservations',
          (json) => (json as List<dynamic>).map<BookingRecordInfo>((dynamic item) {
                return BookingRecordInfo.fromJson(item);
              }).toList(),token);
      if (response.statusCode == 200) {
        setState(() {
          bookingList = response.data;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data Fetch failed'),
          duration: Duration(seconds: 5),
        ));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(0, -1),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: 1170,
                          ),
                          decoration: BoxDecoration(),
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 20, 0, 0),
                        child: Text(
                          'Booking Record',
                          textAlign: TextAlign.start,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF15161E),
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            bookingList == null
                                ? Text("Loading")
                                : ListView.builder(
                                    padding: EdgeInsets.fromLTRB(
                                      0,
                                      8,
                                      0,
                                      0,
                                    ),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: bookingList?.length,
                                    itemBuilder: (context, index) {
                                      BookingRecordInfo currItem =
                                          bookingList![index];
                                      return BookingRecordItem(
                                          bookingRecordInfo: currItem);
                                    }),
                          ],
                        ),
                      ),
                    ],
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
