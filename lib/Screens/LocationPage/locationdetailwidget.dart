import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';
import 'package:user_app/Components/DetailPageContent.dart';
import 'package:user_app/Models/ParkingLotInfo.dart';

import 'locationdetailmodel.dart';
export 'locationdetailmodel.dart';

import 'package:http/http.dart' as http;

class LocationDetailWidget extends StatefulWidget {
  const LocationDetailWidget({super.key});

  @override
  State<LocationDetailWidget> createState() => _LocationDetailWidgetState();
}

class _LocationDetailWidgetState extends State<LocationDetailWidget> {
  late LocationDetailModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int? parkingLotID;
  ParkingLotInfo? parkingLotInfo;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LocationDetailModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<ParkingLotInfo> GetParkingLotInfo() async {
      String loadingUrl ="https://fyp.alexchoicy.live/api/v1/parkinglots/${parkingLotID.toString()}";
      print(loadingUrl);
      final url = Uri.parse(loadingUrl);
      final response = await http.get(url);
      final json = jsonDecode(response.body);
      print(response.statusCode.toString());  
      return parkingLotInfo = ParkingLotInfo.fromJson(json['data']);
  }

  @override
  Widget build(BuildContext context) {
    parkingLotID = ModalRoute.of(context)!.settings.arguments as int;
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child:FutureBuilder<ParkingLotInfo>(
            future: GetParkingLotInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final parkingLotInfo = snapshot.data!;
                return DetailPageContent(parkingLotInfo: parkingLotInfo);
              } else {
                return Center(child: Text('No data available'));
              }
            }
          ),
    );
  }
}
