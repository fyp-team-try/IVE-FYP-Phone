import 'dart:convert';

import 'package:user_app/Models/PaymentObjectModel.dart';

class BookingRecordInfo {
  int reservationID;
  String lotName;
  String spaceType;
  DateTime startTime;
  DateTime endTime;
  String vehicleLicense;
  PaymentObjectModel payment;

  BookingRecordInfo(
      {required this.reservationID,
      required this.lotName,
      required this.spaceType,
      required this.startTime,
      required this.endTime,
      required this.vehicleLicense,
      required this.payment
  });

  factory BookingRecordInfo.fromJson(Map<String, dynamic> json) {
    return BookingRecordInfo(
      reservationID:json['reservationID'],
      lotName: json['lotName'],
      spaceType: json['spaceType'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      vehicleLicense: json['vehicleLicense'],
      payment: PaymentObjectModel.fromJson(json['payment'])
    );
  }

  static Map<String, dynamic> toMap(BookingRecordInfo bookingRecordInfo) {
    return {
      'lotName': bookingRecordInfo.lotName,
      'spaceType': bookingRecordInfo.spaceType,
      'startTime': bookingRecordInfo.startTime,
      'endTime': bookingRecordInfo.endTime,
      'vehicleLicense': bookingRecordInfo.vehicleLicense,
    };
  }

  static BookingRecordInfo deserialize(String json) =>
      BookingRecordInfo.fromJson(jsonDecode(json));
  static String serialize(BookingRecordInfo model) =>
      json.encode(BookingRecordInfo.toMap(model));
}
