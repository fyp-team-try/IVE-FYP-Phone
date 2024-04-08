import 'dart:convert';

import 'package:flutter/material.dart';

class ParkingRecordInfo {
  int parkingRecordID;
  double period;
  DateTime entryTime;
  DateTime? exitTime;
  // reservation;
  double price;
  String spaceType;
  String paymentStatus;

  ParkingRecordInfo(
      {required this.parkingRecordID,
      required this.period,
      required this.entryTime,
      required this.exitTime,
      //required this.reservation,
      required this.price,
      required this.spaceType,
      required this.paymentStatus});

  factory ParkingRecordInfo.fromJson(Map<String, dynamic> json) {
    return ParkingRecordInfo(
      parkingRecordID: json['parkingRecordID'],
      period: json['period'],
      entryTime: DateTime.parse(json['entryTime']),
      exitTime: DateTime.parse(json['exitTime']),
      //reservation: json['reservation'],
      price: json['price'],
      spaceType: json['spaceType'],
      paymentStatus: json['paymentStatus']
    );
  }

  static Map<String, dynamic> toMap(ParkingRecordInfo parkingRecordinfo) {
    return {
      'parkingRecordID': parkingRecordinfo.parkingRecordID,
      'period': parkingRecordinfo.period,
      'entryTime': parkingRecordinfo.entryTime,
      'exitTime': parkingRecordinfo.exitTime,
      //'reservation': parkingRecordinfo.reservation,
      'price': parkingRecordinfo.price,
      'spaceType': parkingRecordinfo.spaceType,
      'paymentStatus': parkingRecordinfo.paymentStatus,
    };
  }

  static ParkingRecordInfo deserialize(String json) =>
      ParkingRecordInfo.fromJson(jsonDecode(json));
  static String serialize(ParkingRecordInfo model) =>
      json.encode(ParkingRecordInfo.toMap(model));
}
