import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user_app/Models/Api/ApiResponse.dart';
import 'package:user_app/Models/Api/RequestModels/AuthRequestModels.dart';
import 'package:user_app/Models/Api/RequestModels/ReservationRequestModel.dart';
import 'package:user_app/Models/UserInfo.dart';

import '../ApiRequest.dart';

Future<bool> createReservationRequest(ReservationRequestModel data, BuildContext context,token) async {
  try {
    ApiRequest api = ApiRequest();
    ApiResponse<ReservationRequestModel> response = await api.post<ReservationRequestModel>(
        data, 
        'reservations', 
        (json) => ReservationRequestModel.fromJson(json as Map<String, dynamic>)
        ,token);

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data.toString()),
        ),
      );
      return true;
    }
    throw Exception(response.errorMessage);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  }
  return false;
}
