import 'dart:convert';

class VehicleInfo {
  int vehicleID;
  String vehicleLicense;
  int vehicleType;

  VehicleInfo(
      {required this.vehicleID,
      required this.vehicleLicense,
      required this.vehicleType,});

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
        vehicleID: json['vehicleID'],
        vehicleLicense: json['vehicleLicense'],
        vehicleType: json['vehicleType']);
  }

  static Map<String, dynamic> toMap(VehicleInfo vehicleInfo) {
    return {
      'vehicleID': vehicleInfo.vehicleID,
      'vehicleLicense': vehicleInfo.vehicleLicense,
      'vehicleType': vehicleInfo.vehicleType
    };
  }

  static VehicleInfo deserialize(String json) =>
      VehicleInfo.fromJson(jsonDecode(json));
  static String serialize(VehicleInfo model) => json.encode(VehicleInfo.toMap(model));
}
