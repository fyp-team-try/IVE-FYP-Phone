import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:user_app/Models/Api/ApiRequestModels.dart';
import 'package:http/http.dart' as http;
import '../Models/Api/ApiResponse.dart';

class ApiRequest {
  final String? baseUrl = dotenv.env['API_BASEURL'];
  final String? version = dotenv.env['API_VERSION'];
  String apiUrl = "";
  ApiRequest() {
    if (baseUrl == null || version == null) {
      throw Exception('API_BASEURL or API_VERSION is not defined in .env file');
    }
    apiUrl = '$baseUrl/$version';
  }


  Future<ApiResponse<T>> post<T>(ApiRequestModels data, String endpoint,
      T Function(Object? json) fromJsonT,[String? token]) async {
    try {
      Uri url = Uri.parse('$apiUrl/$endpoint');
      
      final response = await http.post(url,
          headers: token==null?<String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }:<String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':'Bearer $token'
          }
          ,
          body: data.toJson());
      Map<String, dynamic> json = jsonDecode(response.body);
      ApiResponse<T> apiResponse = ApiResponse.fromJson(json, fromJsonT);
      return apiResponse;
    } catch (e) {}
    throw Exception('Failed to load data');
  }

  Future<ApiResponse<T>> get<T>(String endpoint,
      T Function(Object? json) fromJsonT,[String? token]) async {
    try {
      Uri url = Uri.parse('$apiUrl/$endpoint');
      final response = await http.get(url,
          headers: token==null?<String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }:<String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':'Bearer $token'
          });
      Map<String, dynamic> json = jsonDecode(response.body);
      print(json);
      ApiResponse<T> apiResponse = ApiResponse.fromJson(json, fromJsonT);
      return apiResponse;
    } catch (e) {
      print(e.toString());
    }
    throw Exception('Failed to get data');
  }

  Future<ApiResponse<T>> put<T>(ApiRequestModels data, String endpoint,
      T Function(Object? json) fromJsonT,[String? token]) async {
    try {
      Uri url = Uri.parse('$apiUrl/$endpoint');
      final response = await http.put(url,
          headers: token==null?<String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }:<String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':'Bearer $token'
          }
          ,
          body: data.toJson());
      Map<String, dynamic> json = jsonDecode(response.body);
      ApiResponse<T> apiResponse = ApiResponse.fromJson(json, fromJsonT);
      return apiResponse;
    } catch (e) {}
    throw Exception('Failed to load data');
  }
}
