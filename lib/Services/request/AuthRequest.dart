import 'package:flutter/material.dart';
import 'package:user_app/Models/Api/ApiResponse.dart';
import 'package:user_app/Models/Api/RequestModels/AuthRequestModels.dart';
import 'package:user_app/Models/UserInfo.dart';

import '../ApiRequest.dart';

Future<UserInfo> LoginRequest(
    LoginRequestModels data, BuildContext context) async {
  try {
    ApiRequest api = ApiRequest();
    ApiResponse<UserInfo> response = await api.post<UserInfo>(
        data,
        'auth/login',
        (json) => UserInfo.fromJson(json as Map<String, dynamic>));
    if (response.success) {
      return response.data!;
    }
    throw Exception(response.errorMessage);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  }
  throw Exception('Login request failed.');
}

Future<bool> RegisterRequest(RegisterRequestModel data, BuildContext context) async {
  try {
    ApiRequest api = ApiRequest();
    ApiResponse<String> response = await api.post<String>(
        data, 'auth/register', (json) => json.toString());

    if (response.success) {
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
