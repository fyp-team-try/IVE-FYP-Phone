import 'package:flutter/material.dart';

class GroupedParkingPrices {
  TimeOfDay StarTime;
  TimeOfDay EndTime;
  double price;

  GroupedParkingPrices({required this.StarTime,required this.EndTime,required this.price});
  
  set endTime(TimeOfDay timeOfDay){
    EndTime = timeOfDay;
  }
}
