import 'dart:convert';

import 'package:user_app/Models/Api/ApiRequestModels.dart';

class LoginRequestModels implements ApiRequestModels {
  String username;
  String password;
  LoginRequestModels({required this.username, required this.password});

  @override
  String toJson() {
    return jsonEncode({'username': username, 'password': password});
  }
}
