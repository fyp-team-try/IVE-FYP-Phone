import 'dart:convert';

import 'package:user_app/Models/Api/ApiRequestModels.dart';

class EditReservationRequestModel implements ApiRequestModels {
  int reservationID;
  String startTime;
  String endTime;
  String spaceType;

  EditReservationRequestModel({
    required this.reservationID,
    required this.startTime,
    required this.endTime,
    required this.spaceType
  });

  @override
  String toJson() {
    return jsonEncode({
      'reservationID': reservationID,
      'startTime': startTime,
      'endTime': endTime,
      'spaceType': spaceType
    });
  }


  factory EditReservationRequestModel.fromJson(Map<String, dynamic> json) {
    return EditReservationRequestModel(
        reservationID: json['reservationID'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        spaceType: json['spaceType']);
  }

  static Map<String, dynamic> toMap(EditReservationRequestModel editReservationRequestModel) {
    return {
      'startTime': editReservationRequestModel.startTime,
      'endTime': editReservationRequestModel.endTime,
      'spaceType': editReservationRequestModel.spaceType,
    };
  }

  static EditReservationRequestModel deserialize(String json) =>EditReservationRequestModel.fromJson(jsonDecode(json));
  static String serialize(EditReservationRequestModel model) => json.encode(EditReservationRequestModel.toMap(model));
}
