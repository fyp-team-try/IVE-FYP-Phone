import 'dart:convert';


class RecieveMessageModel {
  String Message;
  int senderID;
  String chatSender;
  DateTime createdAt;

  RecieveMessageModel(
      {required this.Message,
      required this.senderID,
      required this.chatSender,
      required this.createdAt,
  });

  factory RecieveMessageModel.fromJson(Map<String, dynamic> json) {
    return RecieveMessageModel(
      Message: json['message'],
      senderID: json['senderID'],
      chatSender: json['chatSender'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  static Map<String, dynamic> toMap(RecieveMessageModel recieveMessageModel) {
    return {
      'Message': recieveMessageModel.Message,
      'senderID': recieveMessageModel.senderID,
      'chatSender': recieveMessageModel.chatSender,
      'createdAt': recieveMessageModel.createdAt,
    };
  }

  static RecieveMessageModel deserialize(String json) =>
      RecieveMessageModel.fromJson(jsonDecode(json));
  static String serialize(RecieveMessageModel model) =>
      json.encode(RecieveMessageModel.toMap(model));
}
