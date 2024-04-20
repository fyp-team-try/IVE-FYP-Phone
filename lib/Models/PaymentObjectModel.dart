import 'dart:convert';

class PaymentObjectModel {
  int paymentID;
  int userId;
  double amount;
  String paymentType;
  String? paymentMethodType;
  int relatedID;
  String paymentMethod;
  String paymentStatus;
  DateTime? paymentTime;
  DateTime paymentIssuedAt;

  PaymentObjectModel({
    required this.paymentID,
    required this.userId,
    required this.amount,
    required this.paymentType,
    required this.paymentMethodType,
    required this.relatedID,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentTime,
    required this.paymentIssuedAt,
  });

  factory PaymentObjectModel.fromJson(Map<String, dynamic> json) {
    return PaymentObjectModel(
      paymentID: json['paymentID'],
      userId: json['userId'],
      amount: json['amount'],
      paymentType: json['paymentType'],
      paymentMethodType: json['paymentMethodType'],
      relatedID: json['relatedID'],
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      paymentTime: json['paymentTime'] != null
          ? DateTime.parse(json['paymentTime'])
          : null,
      paymentIssuedAt: DateTime.parse(json['paymentIssuedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentID': paymentID,
      'userId': userId,
      'amount': amount,
      'paymentType': paymentType,
      'paymentMethodType': paymentMethodType,
      'relatedID': relatedID,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'paymentTime': paymentTime?.toIso8601String(),
      'paymentIssuedAt': paymentIssuedAt.toIso8601String(),
    };
  }

  static PaymentObjectModel fromMap(Map<String, dynamic> map) {
    return PaymentObjectModel(
      paymentID: map['paymentID'],
      userId: map['userId'],
      amount: map['amount'],
      paymentType: map['paymentType'],
      paymentMethodType: map['paymentMethodType'],
      relatedID: map['relatedID'],
      paymentMethod: map['paymentMethod'],
      paymentStatus: map['paymentStatus'],
      paymentTime: map['paymentTime'] != null
          ? DateTime.parse(map['paymentTime'])
          : null,
      paymentIssuedAt: DateTime.parse(map['paymentIssuedAt']),
    );
  }

  static Map<String, dynamic> toMap(PaymentObjectModel model) {
    return model.toJson();
  }

  static PaymentObjectModel deserialize(String json) =>
      PaymentObjectModel.fromJson(jsonDecode(json));

  static String serialize(PaymentObjectModel model) =>
      json.encode(PaymentObjectModel.toMap(model));
}
