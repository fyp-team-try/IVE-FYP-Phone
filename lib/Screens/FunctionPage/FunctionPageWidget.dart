import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:user_app/Components/FunctionPageButton.dart';

import 'FunctionPageModel.dart';
export 'FunctionPageModel.dart';

class FunctionPageWidget extends StatefulWidget {
  const FunctionPageWidget({super.key});

  @override
  State<FunctionPageWidget> createState() => _FunctionPageWidgetState();
}

class _FunctionPageWidgetState extends State<FunctionPageWidget> {
  late FunctionPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FunctionPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Page Title',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FunctionPageButton(
                        onTap: (){Navigator.pushNamed(context, "/BookingHistory");},
                        //onTap:()=>testOnTap(),
                        text: "booking",
                        imagePath: "assets/images/booking.png"),
                    FunctionPageButton(
                        onTap: (){Navigator.pushNamed(context, "/ChatRooms");},
                        text: "Message",
                        imagePath: "assets/images/message.png"),
                    FunctionPageButton(
                        onTap: (){Navigator.pushNamed(context, "/history");},
                        text: "Record",
                        imagePath: "assets/images/record.png"),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FunctionPageButton(
                        onTap: (){Navigator.pushNamed(context, "/location");},
                        text: "Map",
                        imagePath: "assets/images/map.png"),
                    FunctionPageButton(
                        onTap: () => Navigator.pushNamed(context,'/paymentList'),
                        text: "Payment",
                        imagePath: "assets/images/payment.png"),
                    FunctionPageButton(
                        onTap: (){Navigator.pushNamed(context, "/Setting");},
                        text: "Setting",
                        imagePath: "assets/images/settings.png"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void testOnTap() async {
    /*
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("clicked"),
      duration: const Duration(seconds: 2),
    ));
    */
  }
}
