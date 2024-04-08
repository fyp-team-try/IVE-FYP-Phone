import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Components/ManageVehicleItem.dart';
import 'package:user_app/Models/Api/ApiResponse.dart';
import 'package:user_app/Models/MyInfo.dart';
import 'package:user_app/Models/VehicleInfo.dart';
import 'package:user_app/Providers/AuthProvider.dart';
import 'package:user_app/Services/ApiRequest.dart';
import 'ManageVehicleModel.dart';
export 'ManageVehicleModel.dart';

class ManageVehicleWidget extends StatefulWidget {
  const ManageVehicleWidget({super.key});

  @override
  State<ManageVehicleWidget> createState() => _ManageVehicleWidgetState();
}

class _ManageVehicleWidgetState extends State<ManageVehicleWidget> {
  late ManageVehicleModel _model;

  List<VehicleInfo>? vehicleList = <VehicleInfo>[];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ManageVehicleModel());
    GetVehicles();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

    void GetVehicles() async {
    try {
      ApiRequest api = ApiRequest();

      String token = context.read<AuthProvider>().getUserInfo().token;
      ApiResponse<MyInfo> idResponse = await api.get(
          'me', (json) => MyInfo.fromJson(json as Map<String, dynamic>), token);

      ApiResponse<List<VehicleInfo>> response = await api.get(
          'users/${idResponse.data?.userID}/vehicles',
          (json) => (json as List<dynamic>).map<VehicleInfo>((dynamic item) {
                return VehicleInfo.fromJson(item);
              }).toList(),token);

      print(response.errorMessage);
      print(idResponse.errorMessage);
      if (response.statusCode == 200) {
        setState(() {
          vehicleList = response.data;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Data Fetch failed'),
          duration: Duration(seconds: 5),
        ));
      }
    } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 5),
        ));
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Manage Vehicle',
            style: FlutterFlowTheme.of(context).displaySmall.override(
                  fontFamily: 'Outfit',
                  fontSize: 36,
                ),
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
              Container(
                width: 468,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text(
                              'My vehicle',
                              style: FlutterFlowTheme.of(context).titleLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    vehicleList == null
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          8,
                          0,
                          0,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: vehicleList?.length,
                        itemBuilder: (context, index) {
                          VehicleInfo currItem = vehicleList![index];
                          return ManageVehicleItem(vehicleInfo: currItem);
                        }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                            child: Container(
                              width: double.infinity,
                              height: 64,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 1),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1,
                                ),
                              ),
                              child: FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 40,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                icon: Icon(
                                  Icons.directions_car,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24,
                                ),
                                onPressed: () async {
                                  Navigator.pushNamed(context,'/AddVehicle');
                                },
                              ),
                            ),
                          ),
                          Text(
                            'Add vehicle',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ].divide(SizedBox(width: 12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
