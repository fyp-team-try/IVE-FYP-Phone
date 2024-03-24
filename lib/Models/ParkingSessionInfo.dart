import 'dart:convert';

import 'package:user_app/Models/ParkingRecordInfo.dart';

class ParkingSessionInfo {
  int sessionID;
  //int lotID;
  //String lotName;
  //String vehicleLicense;
  //double? totalPrice;
  //List<ParkingRecordInfo>? records;

  ParkingSessionInfo(
      {required this.sessionID,
      //required this.lotID,
      //required this.lotName,
      //required this.vehicleLicense,
      //required this.totalPrice,
      //required this.records
      });

  factory ParkingSessionInfo.fromJson(Map<String, dynamic> json) {
    /*List<ParkingRecordInfo> prRecords = json['records']!=null?
        json['records'].map<ParkingRecordInfo>((json) => ParkingRecordInfo.fromJson(json))
        .toList():[];*/

    return ParkingSessionInfo(
        sessionID: json['sessionID'],
        //lotID: json['lotID'],
        //lotName: json['lotName'],
        //vehicleLicense: json['vehicleLicense'],
        //totalPrice: json['totalPrice']
        //records: prRecords
        );
  }

  static Map<String, dynamic> toMap(ParkingSessionInfo parkingSessionInfo) {
    return {
      'sessionID': parkingSessionInfo.sessionID,
      //'lotID': parkingSessionInfo.lotID,
      //'lotName': parkingSessionInfo.lotName,
      //'vehicleLicense': parkingSessionInfo.vehicleLicense,
      //'totalPrice': parkingSessionInfo.totalPrice,
    };
  }

  static ParkingSessionInfo deserialize(String json) =>ParkingSessionInfo.fromJson(jsonDecode(json));
  static String serialize(ParkingSessionInfo model) => json.encode(ParkingSessionInfo.toMap(model));
}
