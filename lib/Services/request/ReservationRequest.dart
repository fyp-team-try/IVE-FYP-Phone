import 'package:flutter/material.dart';
import 'package:user_app/Models/Api/ApiResponse.dart';
import 'package:user_app/Models/Api/RequestModels/ReservationRequestModel.dart';

import '../ApiRequest.dart';

Future<bool> createReservationRequest(ReservationRequestModel data, BuildContext context,token) async {
  try {
    ApiRequest api = ApiRequest();
    ApiResponse<String> response = await api.post<String>(
        data, 
        'reservations', 
        (json) => json.toString()
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