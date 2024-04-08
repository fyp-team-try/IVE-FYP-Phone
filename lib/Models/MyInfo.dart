import 'dart:convert';

class MyInfo {
  int userID;

  MyInfo({
    required this.userID,
  });

  factory MyInfo.fromJson(Map<String, dynamic> json) {
    return MyInfo(userID: json['userID']);
  }

  static Map<String, dynamic> toMap(MyInfo myInfo) {
    return {
      'userID': myInfo.userID,
    };
  }

  static MyInfo deserialize(String json) => MyInfo.fromJson(jsonDecode(json));
  static String serialize(MyInfo model) => json.encode(MyInfo.toMap(model));
}
