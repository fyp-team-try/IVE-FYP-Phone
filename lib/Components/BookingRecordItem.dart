import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:user_app/Models/ParkingSessionInfo.dart';
import 'package:user_app/Models/ReservationRecorrdInfo.dart';

class BookingRecordItem extends StatelessWidget {
  final BookingRecordInfo bookingRecordInfo;


  

  const BookingRecordItem({required this.bookingRecordInfo});

  
  @override
  Widget build(BuildContext context) {
    String enterDateString = "${bookingRecordInfo.startTime.day}-${bookingRecordInfo.startTime.month}-${bookingRecordInfo.startTime.year}";
    String exitDateString = "${bookingRecordInfo.endTime.day}-${bookingRecordInfo.endTime.month}-${bookingRecordInfo.endTime.year}";
    String enterTimeString = "${bookingRecordInfo.startTime.hour.toString().padLeft(2, '0')}:${bookingRecordInfo.startTime.minute.toString().padLeft(2, '0')}";
    String exitTimeString = "${bookingRecordInfo.endTime.hour.toString().padLeft(2, '0')}:${bookingRecordInfo.endTime.minute.toString().padLeft(2, '0')}";

    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, "/BookingModify",arguments:bookingRecordInfo);
      },
      child:Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.92,
        height: 120,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x35000000),
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primaryBackground,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(68, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${bookingRecordInfo.lotName}",
                        style: FlutterFlowTheme.of(context).bodyLarge,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Vehicle license:${bookingRecordInfo.vehicleLicense}',
                          style: FlutterFlowTheme.of(context).labelSmall,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Lot type:${bookingRecordInfo.spaceType}',
                          style: FlutterFlowTheme.of(context).labelSmall,
                        ),
                      ),
                                            Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Start time: $enterDateString $enterTimeString 00',
                          style: FlutterFlowTheme.of(context).labelSmall,
                        ),
                      ),
                                            Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'End time:  $exitDateString $exitTimeString 00',
                          style: FlutterFlowTheme.of(context).labelSmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "ID:${bookingRecordInfo.reservationID}",
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.of(context).titleLarge,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text("",
                        textAlign: TextAlign.end,
                        style: FlutterFlowTheme.of(context).labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
