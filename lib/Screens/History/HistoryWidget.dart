import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Components/ParkingRecordItem.dart';
import 'package:user_app/Models/Api/ApiResponse.dart';
import 'package:user_app/Models/MyInfo.dart';
import 'package:user_app/Models/ParkingSessionInfo.dart';
import 'package:user_app/Models/ParkingSessionPageInfo.dart';
import 'package:user_app/Providers/AuthProvider.dart';
import 'package:user_app/Services/ApiRequest.dart';

import 'HistoryModel.dart';
export 'HistoryModel.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  late HistoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  ParkingSessionPageInfo? parkingSessionPage;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryModel());
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

      ApiResponse<ParkingSessionPageInfo> response = await api.get(
          'users/${idResponse.data?.userID}/parkingrecords',
          (json) =>
              ParkingSessionPageInfo.fromJson(json as Map<String, dynamic>),
          token);
      if (response.statusCode == 200) {
        setState(() {
          parkingSessionPage = response.data;
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
                          'Parking Record',
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
                            parkingSessionPage == null
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
                                    itemCount: parkingSessionPage
                                        ?.parkingSessionList?.length,
                                    itemBuilder: (context, index) {
                                      ParkingSessionInfo currItem =
                                          parkingSessionPage!
                                              .parkingSessionList![index];
                                      return ParkingRecordItem(
                                          parkingSessionInfo: currItem);
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
