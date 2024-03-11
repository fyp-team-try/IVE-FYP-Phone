import 'package:flutter/material.dart';

class ParkingLotPrices {
  TimeOfDay time;
  double price;

  ParkingLotPrices({required this.time, required this.price});

  factory ParkingLotPrices.fromJson(Map<String, dynamic> json) {
    var timeParts = json['time'].split(':');
    var time = TimeOfDay(
        hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));

    return ParkingLotPrices(
      time: time,
      price: json['price'],
    );
  }
}
