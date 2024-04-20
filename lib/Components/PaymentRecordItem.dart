import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:user_app/Models/ParkingSessionInfo.dart';
import 'package:user_app/Models/PaymentObjectModel.dart';
import 'package:user_app/Models/ReservationRecorrdInfo.dart';

class PaymentRecordItem extends StatelessWidget {
  final BookingRecordInfo bookingRecordInfo;


  

  const PaymentRecordItem({required this.bookingRecordInfo});

  
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, "/payment",arguments:bookingRecordInfo);
      },
      child:Padding(
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
                        "${bookingRecordInfo.payment.paymentID}",
                        style: FlutterFlowTheme.of(context).bodyLarge,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          '',
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
                      child: Text('',
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
