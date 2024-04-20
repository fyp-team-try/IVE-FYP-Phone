import 'package:flutter/material.dart';
import 'package:user_app/Models/Api/ApiResponse.dart';
import 'package:user_app/Models/Api/RequestModels/ReservationRequestModel.dart';
import 'package:user_app/Models/Api/RequestModels/reservationPaymentModel.dart';
import 'package:user_app/Models/MyInfo.dart';

import '../ApiRequest.dart';

Future<bool> parkingPaymentRequest(reservationPaymentModel data, BuildContext context,int sessionID,token) async {
  try {
    print(sessionID);
    ApiRequest api = ApiRequest();
    ApiResponse<MyInfo> idResponse = await api.get(
          'me', (json) => MyInfo.fromJson(json as Map<String, dynamic>), token);
    ApiResponse<String> response = await api.post<String>(
        data, 
        'users/${idResponse.data!.userID}/parkingrecords/${sessionID}/payment', 
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
