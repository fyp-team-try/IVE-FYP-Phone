import 'package:flutter/widgets.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Components/CreditCardDisplay.dart';
import 'package:user_app/Models/Api/RequestModels/reservationPaymentModel.dart';
import 'package:user_app/Models/ParkingSessionInfo.dart';
import 'package:user_app/Providers/AuthProvider.dart';
import 'package:user_app/Services/request/ParkingPaymentRequest.dart';
import 'package:user_app/Services/request/ReservationPaymentRequest.dart';

import 'ParkingPaymentModel.dart';
export 'ParkingPaymentModel.dart';

class ParkingPaymentWidget extends StatefulWidget {
  const ParkingPaymentWidget({super.key});

  @override
  State<ParkingPaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<ParkingPaymentWidget> {
  late ParkingPaymentModel _model;


  ParkingSessionInfo? parkingSessionInfo;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ParkingPaymentModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

    void pay() async{
try {
    String token = context.read<AuthProvider>().getUserInfo().token;
        reservationPaymentModel ReservationPaymentModel = reservationPaymentModel(paymentMethod: "App", paymentMethodType: "CreditCard");

        bool isRegSuccess = await parkingPaymentRequest(ReservationPaymentModel, context, parkingSessionInfo!.sessionID, token);

        if (isRegSuccess) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pay Successful'),
                content: Text('You have finish paymenet for parking.'),
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
      } catch (e) {}
  }


  @override
  Widget build(BuildContext context) {
     parkingSessionInfo = ModalRoute.of(context)!.settings.arguments as ParkingSessionInfo;
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(64),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            title: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment',
                  style: FlutterFlowTheme.of(context).headlineLarge,
                ),
              ],
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 470,
                      ),
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Container(
                                width: double.infinity,
                                height: 190,
                                child: 
                                CarouselSlider(
                                items: [
                                  CreditCardDisplay(),
                                  CreditCardDisplay()
                                ],
                                carouselController:
                                    _model.carouselController ??=
                                        CarouselController(),
                                options: CarouselOptions(
                                  initialPage: 0,
                                  viewportFraction: 0.8,
                                  disableCenter: true,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.25,
                                  enableInfiniteScroll: true,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: false,
                                  onPageChanged: (index, _) =>
                                      _model.carouselCurrentIndex = index,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ].addToEnd(SizedBox(height: 44)),
                ),
              ),
              Opacity(
                opacity: 1,
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: 430,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Summary',
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Outfit',
                                    fontSize: 18,
                                  ),
                        ),
                        Divider(
                          height: 32,
                          thickness: 2,
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Car Lot : ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    Text(
                                      '${parkingSessionInfo!.lotName}',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Car plate :',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    Text(
                                      '${parkingSessionInfo!.vehicleLicense}',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Start Time :',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    Text(
                                      '${parkingSessionInfo!.entryTime.day.toString().padLeft(2, '0')}-${parkingSessionInfo!.entryTime.month.toString().padLeft(2, '0')}-${parkingSessionInfo!.entryTime.year.toString().padLeft(2, '0')} ${parkingSessionInfo!.entryTime.hour.toString().padLeft(2, '0')}:${parkingSessionInfo!.entryTime.minute.toString().padLeft(2, '0')}',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'End Time :',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                    Text(
                                      '${parkingSessionInfo!.exitTime!.day.toString().padLeft(2, '0')}-${parkingSessionInfo!.exitTime!.month.toString().padLeft(2, '0')}-${parkingSessionInfo!.exitTime!.year.toString().padLeft(2, '0')} ${parkingSessionInfo!.exitTime!.hour.toString().padLeft(2, '0')}:${parkingSessionInfo!.exitTime!.minute.toString().padLeft(2, '0')}',
                                      textAlign: TextAlign.end,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          'Total',
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily: 'Outfit',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '\$${parkingSessionInfo!.totalPrice}',
                                      style: FlutterFlowTheme.of(context)
                                          .displaySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            pay();
                          },
                          text: 'Pay',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50,
                            padding: EdgeInsets.all(0),
                            iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).primaryText,
                            textStyle: FlutterFlowTheme.of(context).titleSmall,
                            elevation: 2,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            hoverColor: FlutterFlowTheme.of(context).accent1,
                            hoverBorderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 1,
                            ),
                            hoverTextColor:
                                FlutterFlowTheme.of(context).primary,
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
    );
  }
}
