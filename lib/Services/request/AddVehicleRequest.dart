import 'package:flutter/material.dart';
import 'package:user_app/Models/Api/ApiResponse.dart';
import 'package:user_app/Models/Api/RequestModels/AddVehicleRequestModel.dart';
import 'package:user_app/Models/MyInfo.dart';

import '../ApiRequest.dart';

Future<bool> addVehicleRequest(AddVehicleRequestModel data, BuildContext context,token) async {
  try {
    ApiRequest api = ApiRequest();
    ApiResponse<MyInfo> idResponse = await api.get(
          'me', (json) => MyInfo.fromJson(json as Map<String, dynamic>), token);
    ApiResponse<String> response = await api.post<String>(
        data, 
        'users/${idResponse.data?.userID}/vehicles', 
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
