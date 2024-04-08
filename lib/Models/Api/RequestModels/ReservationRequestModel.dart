import 'dart:convert';

import 'package:user_app/Models/Api/ApiRequestModels.dart';

class ReservationRequestModel implements ApiRequestModels {
  int vehicleID;
  int lotID;
  //String for Iso8601 String,DateTime is not used
  String startTime;
  String endTime;
  String spaceType;

  ReservationRequestModel(
      {required this.vehicleID,
      required this.lotID,
      required this.startTime,
      required this.endTime,
      required this.spaceType});

  @override
  String toJson() {
    return jsonEncode({
      'vehicleID': vehicleID,
      'lotID': lotID,
      'startTime': startTime,
      'endTime': endTime,
      'spaceType': spaceType
    });
  }


  factory ReservationRequestModel.fromJson(Map<String, dynamic> json) {
    return ReservationRequestModel(
        vehicleID: json['vehicleID'],
        lotID: json['lotID'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        spaceType: json['spaceType']);
  }

  static Map<String, dynamic> toMap(ReservationRequestModel reservationRequestModel) {
    return {
      'vehicleID': reservationRequestModel.vehicleID,
      'lotID': reservationRequestModel.lotID,
      'startTime': reservationRequestModel.startTime,
      'endTime': reservationRequestModel.endTime,
      'spaceType': reservationRequestModel.spaceType,
    };
  }

  static ReservationRequestModel deserialize(String json) =>ReservationRequestModel.fromJson(jsonDecode(json));
  static String serialize(ReservationRequestModel model) => json.encode(ReservationRequestModel.toMap(model));
}
