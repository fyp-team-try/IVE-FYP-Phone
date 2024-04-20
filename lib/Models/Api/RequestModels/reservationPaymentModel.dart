import 'dart:convert';

import 'package:user_app/Models/Api/ApiRequestModels.dart';

class reservationPaymentModel implements ApiRequestModels {
  String paymentMethod;
  String paymentMethodType;

  reservationPaymentModel(
      {required this.paymentMethod,
      required this.paymentMethodType});

  @override
  String toJson() {
    return jsonEncode({
      'paymentMethod': paymentMethod,
      'paymentMethodType': paymentMethodType,
    });
  }


  factory reservationPaymentModel.fromJson(Map<String, dynamic> json) {
    return reservationPaymentModel(
        paymentMethod: json['paymentMethod'],
        paymentMethodType: json['paymentMethodType']);
  }

  static Map<String, dynamic> toMap(reservationPaymentModel RreservationPaymentModel) {
    return {
      'paymentMethod': RreservationPaymentModel.paymentMethod,
      'paymentMethodType': RreservationPaymentModel.paymentMethodType,
    };
  }

  static reservationPaymentModel deserialize(String json) =>reservationPaymentModel.fromJson(jsonDecode(json));
  static String serialize(reservationPaymentModel model) => json.encode(reservationPaymentModel.toMap(model));
}
