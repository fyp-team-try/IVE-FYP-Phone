import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:user_app/Models/ParkingRecordInfo.dart';
import 'package:user_app/Models/ParkingSessionInfo.dart';

class ParkingPaymentItem extends StatelessWidget {
  final ParkingSessionInfo parkingSessionInfo;

  const ParkingPaymentItem({required this.parkingSessionInfo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/parkingPayment",
              arguments: parkingSessionInfo);
        },
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.92,
            height: 100,
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
                            "Session ID：${parkingSessionInfo.sessionID}",
                            style: FlutterFlowTheme.of(context).bodyLarge,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                              'Type: Parking fee',
                              style: FlutterFlowTheme.of(context).labelSmall,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                              'Amount: \$${parkingSessionInfo.totalPrice}',
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
                          "",
                          textAlign: TextAlign.end,
                          style: FlutterFlowTheme.of(context).titleLarge,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            '',
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
