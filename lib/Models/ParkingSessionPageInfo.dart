import 'dart:convert';

import 'package:user_app/Models/ParkingSessionInfo.dart';

class ParkingSessionPageInfo {
  int currentPage;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasNext;
  bool hasPrevious;
  List<ParkingSessionInfo>? parkingSessionList;

  ParkingSessionPageInfo(
      {required this.currentPage,
      required this.pageSize,
      required this.totalCount,
      required this.totalPages,
      required this.hasNext,
      required this.hasPrevious,
      required this.parkingSessionList});

  factory ParkingSessionPageInfo.fromJson(Map<String, dynamic> json) {
    List<ParkingSessionInfo> parkingSessionList = json['data']!=null?
        json['data'].map<ParkingSessionInfo>((json) => ParkingSessionInfo.fromJson(json as Map<String,dynamic>))
        .toList():[];

    return ParkingSessionPageInfo(
        currentPage: json['currentPage'],
        pageSize: json['pageSize'],
        totalCount: json['totalCount'],
        totalPages: json['totalPages'],
        hasNext: json['hasNext'],
        hasPrevious: json['hasPrevious'],
        parkingSessionList: parkingSessionList);
  }

  static Map<String, dynamic> toMap(ParkingSessionPageInfo parkingSessionInfo) {
    return {
      'currentPage': parkingSessionInfo.currentPage,
      'pageSize': parkingSessionInfo.pageSize,
      'totalCount': parkingSessionInfo.totalCount,
      'totalPages': parkingSessionInfo.totalPages,
      'hasNext': parkingSessionInfo.hasNext,
      'hasPrevious': parkingSessionInfo.hasNext,
    };
  }

  static ParkingSessionPageInfo deserialize(String json) =>
      ParkingSessionPageInfo.fromJson(jsonDecode(json));
  static String serialize(ParkingSessionPageInfo model) =>
      json.encode(ParkingSessionPageInfo.toMap(model));
}
