import 'dart:convert';

class ParkingLotInfo {
  int lotID;
  String name;
  String address;
  double latitude;
  double longtitude;
  int totalSpaces;
  int availableSpaces;

  ParkingLotInfo(
      {required this.lotID,
      required this.name,
      required this.address,
      required this.latitude,
      required this.longtitude,
      required this.totalSpaces,
      required this.availableSpaces}
      );

  factory ParkingLotInfo.fromJson(Map<String, dynamic> json) {
    return ParkingLotInfo(
        lotID: json['lotID'],
        name: json['name'],
        address: json['address'],
        latitude: json['latitude'],
        longtitude: json['longitude'],
        totalSpaces: json['totalSpaces'],
        availableSpaces: json['availableSpaces']);
  }

  static Map<String, dynamic> toMap(ParkingLotInfo parkingLotInfo) {
    return {
      'lotID': parkingLotInfo.lotID,
      'name': parkingLotInfo.name,
      'address': parkingLotInfo.address,
      'latitude': parkingLotInfo.latitude,
      'longtitude': parkingLotInfo.longtitude,
      'totalSpaces': parkingLotInfo.totalSpaces,
      'availableSpaces': parkingLotInfo.availableSpaces
    };
  }

  static ParkingLotInfo deserialize(String json) =>ParkingLotInfo.fromJson(jsonDecode(json));
  static String serialize(ParkingLotInfo model) => json.encode(ParkingLotInfo.toMap(model));
}
