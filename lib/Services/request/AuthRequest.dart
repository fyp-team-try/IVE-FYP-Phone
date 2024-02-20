import 'package:flutter/material.dart';
import 'package:user_app/Models/Api/ApiRequestModels/AuthRequestModels.dart';
import 'package:user_app/Models/UserInfo.dart';

import '../ApiRequest.dart';

Future<UserInfo> LoginRequest(
    LoginRequestModels data, BuildContext context) async {
  try {
    ApiRequest api = ApiRequest();
    var response = await api.post<UserInfo>(data, 'auth/login',
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
