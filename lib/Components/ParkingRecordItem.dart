import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:user_app/Models/ParkingSessionInfo.dart';

class ParkingRecordItem extends StatelessWidget {
  final ParkingSessionInfo parkingSessionInfo;


  

  const ParkingRecordItem({required this.parkingSessionInfo});

  
  @override
  Widget build(BuildContext context) {
    String enterDateString = "${parkingSessionInfo.entryTime.day}-${parkingSessionInfo.entryTime.month}-${parkingSessionInfo.entryTime.year}";
    String exitDateString = "${parkingSessionInfo.exitTime?.day}-${parkingSessionInfo.exitTime?.month}-${parkingSessionInfo.exitTime?.year}";
    String enterTimeString = "${parkingSessionInfo.entryTime.hour.toString().padLeft(2, '0')}:${parkingSessionInfo.entryTime.minute.toString().padLeft(2, '0')}";
    String exitTimeString = "${parkingSessionInfo.exitTime?.hour.toString().padLeft(2, '0')}:${parkingSessionInfo.exitTime?.minute.toString().padLeft(2, '0')}";

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.92,
        height: 70,
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
                        parkingSessionInfo.lotName,
                        style: FlutterFlowTheme.of(context).bodyLarge,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          parkingSessionInfo.exitTime!=null?'$enterDateString to $exitDateString':'Not exit yet',
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
                      "\$${parkingSessionInfo.totalPrice??"0.0"}",
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.of(context).titleLarge,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(parkingSessionInfo.exitTime!=null?'${enterTimeString} to $exitTimeString':'',
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
    );
  }
}
