import 'dart:convert';

class ParkingLotInfo {
  int lotID;
  String name;
  String address;
  double latitude;
  double longitude;
  int totalSpaces;
  int regularSpaces;
  int electricSpaces;
  int regularPlanSpaces;
  int electricPlanSpaces;
  double walkinReservedRatio;
  int reservableOnlySpaces;
  double reservedDiscount;
  int minReservationWindowHours;
  int maxReservationHours;
  int availableRegularSpaces;
  int availableElectricSpaces;

  ParkingLotInfo({
    required this.lotID,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.totalSpaces,
    required this.regularSpaces,
    required this.electricSpaces,
    required this.regularPlanSpaces,
    required this.electricPlanSpaces,
    required this.walkinReservedRatio,
    required this.reservableOnlySpaces,
    required this.reservedDiscount,
    required this.minReservationWindowHours,
    required this.maxReservationHours,
    required this.availableRegularSpaces,
    required this.availableElectricSpaces,
  });

  factory ParkingLotInfo.fromJson(Map<String, dynamic> json) {
    return ParkingLotInfo(
      lotID: json['lotID'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      totalSpaces: json['totalSpaces'],
      regularSpaces: json['regularSpaces'],
      electricSpaces: json['electricSpaces'],
      regularPlanSpaces: json['regularPlanSpaces'],
      electricPlanSpaces: json['electricPlanSpaces'],
      walkinReservedRatio: json['walkinReservedRatio'],
      reservableOnlySpaces: json['reservableOnlySpaces'],
      reservedDiscount: json['reservedDiscount'],
      minReservationWindowHours: json['minReservationWindowHours'],
      maxReservationHours: json['maxReservationHours'],
      availableRegularSpaces: json['availableRegularSpaces'],
      availableElectricSpaces: json['availableElectricSpaces'],
    );
  }

  static Map<String, dynamic> toMap(ParkingLotInfo parkingLotInfo) {
    return {
      'lotID': parkingLotInfo.lotID,
      'name': parkingLotInfo.name,
      'address': parkingLotInfo.address,
      'latitude': parkingLotInfo.latitude,
      'longitude': parkingLotInfo.longitude,
      'totalSpaces': parkingLotInfo.totalSpaces,
      'regularSpaces': parkingLotInfo.regularSpaces,
      'electricSpaces': parkingLotInfo.electricSpaces,
      'regularPlanSpaces': parkingLotInfo.regularPlanSpaces,
      'electricPlanSpaces': parkingLotInfo.electricPlanSpaces,
      'walkinReservedRatio': parkingLotInfo.walkinReservedRatio,
      'reservableOnlySpaces': parkingLotInfo.reservableOnlySpaces,
      'reservedDiscount': parkingLotInfo.reservedDiscount,
      'minReservationWindowHours': parkingLotInfo.minReservationWindowHours,
      'maxReservationHours': parkingLotInfo.maxReservationHours,
      'availableRegularSpaces': parkingLotInfo.availableRegularSpaces,
      'availableElectricSpaces': parkingLotInfo.availableElectricSpaces,
    };
  }

  static ParkingLotInfo deserialize(String json) =>ParkingLotInfo.fromJson(jsonDecode(json));
  static String serialize(ParkingLotInfo model) => json.encode(ParkingLotInfo.toMap(model));
}