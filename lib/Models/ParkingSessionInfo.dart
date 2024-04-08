import 'dart:convert';

import 'package:user_app/Models/ParkingRecordInfo.dart';

class ParkingSessionInfo {
  int sessionID;
  int lotID;
  String lotName;
  String vehicleLicense;
  DateTime entryTime;
  DateTime? exitTime;
  double? totalPrice;
  List<ParkingRecordInfo> records;


  ParkingSessionInfo(
      {required this.sessionID,
      required this.lotID,
      required this.lotName,
      required this.vehicleLicense,
      required this.entryTime,
      required this.exitTime,
      required this.totalPrice,
      required this.records
      });

  factory ParkingSessionInfo.fromJson(Map<String, dynamic> json) {
    List<ParkingRecordInfo> parkingRecordList = json['data']!=null?
        json['data'].map<ParkingRecordInfo>((json) => ParkingRecordInfo.fromJson(json as Map<String,dynamic>))
        .toList():[];

    return ParkingSessionInfo(
        sessionID: json['sessionID'],
        lotID: json['lotID'],
        lotName: json['lotName'],
        vehicleLicense: json['vehicleLicense'],
        entryTime: DateTime.parse(json['entryTime']),
        exitTime: json['exitTime'] != null ? DateTime.parse(json['exitTime']) : null,
        totalPrice: json['totalPrice'],
        records: parkingRecordList
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
