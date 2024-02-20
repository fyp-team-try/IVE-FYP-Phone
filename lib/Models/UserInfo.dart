import 'dart:convert';

class UserInfo {
  String token;
  String userName;
  String phoneNumber;
  String firstName;
  String lastName;
  String email;

  UserInfo(
      {required this.token,
      required this.userName,
      required this.phoneNumber,
      required this.firstName,
      required this.lastName,
      required this.email});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        token: json['token'],
        userName: json['userName'],
        phoneNumber: json['phoneNumber'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email']);
  }

  static Map<String, dynamic> toMap(UserInfo userInfo) {
    return {
      'token': userInfo.token,
      'userName': userInfo.userName,
      'phoneNumber': userInfo.phoneNumber,
      'firstName': userInfo.firstName,
      'lastName': userInfo.lastName,
      'email': userInfo.email
    };
  }

  static UserInfo deserialize(String json) =>
      UserInfo.fromJson(jsonDecode(json));
  static String serialize(UserInfo model) => json.encode(UserInfo.toMap(model));
}
