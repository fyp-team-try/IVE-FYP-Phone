import 'dart:convert';

import 'package:user_app/Models/Api/ApiRequestModels.dart';

class AddVehicleRequestModel implements ApiRequestModels {
  String vehicleLicense;
  String vehicleType;
  AddVehicleRequestModel({required this.vehicleLicense, required this.vehicleType});

  @override
  String toJson() {
    return jsonEncode({'vehicleLicense': vehicleLicense, 'vehicleType': vehicleType});
  }
}

