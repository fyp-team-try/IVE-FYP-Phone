import 'dart:convert';

import 'package:user_app/Models/Api/ResponseModels/ParkingLotPrices.dart';

class ParkingLotInfo {
  int lotID;
  String name;
  String address;
  String district;
  double latitude;
  double longitude;
  int totalSpaces;
  int regularSpaces;
  int electricSpaces;
  int regularPlanSpaces;
  int electricPlanSpaces;
  double walkinReservedRatio;
  int reservableOnlyRegularSpaces;
  int reservableOnlyElectricSpaces;
  double reservedDiscount;
  int minReservationWindowHours;
  int maxReservationHours;
  int availableRegularSpaces;
  int availableElectricSpaces;
  List<ParkingLotPrices> regularSpacePrices;
  List<ParkingLotPrices> electricSpacePrices;

  ParkingLotInfo(
      {required this.lotID,
      required this.name,
      required this.address,
      required this.district,
      required this.latitude,
      required this.longitude,
      required this.totalSpaces,
      required this.regularSpaces,
      required this.electricSpaces,
      required this.regularPlanSpaces,
      required this.electricPlanSpaces,
      required this.walkinReservedRatio,
      required this.reservableOnlyRegularSpaces,
      required this.reservableOnlyElectricSpaces,
      required this.reservedDiscount,
      required this.minReservationWindowHours,
      required this.maxReservationHours,
      required this.availableRegularSpaces,
      required this.availableElectricSpaces,
      required this.regularSpacePrices,
      required this.electricSpacePrices});

  factory ParkingLotInfo.fromJson(Map<String, dynamic> json) {
    List<ParkingLotPrices> regularSpacePrices = json['regularSpacePrices']!=null?
        json['regularSpacePrices'].map<ParkingLotPrices>((json) => ParkingLotPrices.fromJson(json))
        .toList():[];
    List<ParkingLotPrices> electricSpacePrices = json['electricSpacePrices']!=null?
        json['electricSpacePrices'].map<ParkingLotPrices>((json) => ParkingLotPrices.fromJson(json))
        .toList():[];

    return ParkingLotInfo(
      lotID: json['lotID'],
      name: json['name'],
      address: json['address'],
      district: json['district'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      totalSpaces: json['totalSpaces'],
      regularSpaces: json['regularSpaces'],
      electricSpaces: json['electricSpaces'],
      regularPlanSpaces: json['regularPlanSpaces'],
      electricPlanSpaces: json['electricPlanSpaces'],
      walkinReservedRatio: json['walkinReservedRatio'],
      reservableOnlyRegularSpaces: json['reservableOnlyRegularSpaces'],
      reservableOnlyElectricSpaces: json['reservableOnlyElectricSpaces'],
      reservedDiscount: json['reservedDiscount'],
      minReservationWindowHours: json['minReservationWindowHours'],
      maxReservationHours: json['maxReservationHours'],
      availableRegularSpaces: json['availableRegularSpaces'],
      availableElectricSpaces: json['availableElectricSpaces'],
      regularSpacePrices: regularSpacePrices,
      electricSpacePrices: electricSpacePrices,
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
      'reservableOnlyRegularSpaces': parkingLotInfo.reservableOnlyRegularSpaces,
      'reservableOnlyElectricSpaces':
          parkingLotInfo.reservableOnlyRegularSpaces,
      'reservedDiscount': parkingLotInfo.reservedDiscount,
      'minReservationWindowHours': parkingLotInfo.minReservationWindowHours,
      'maxReservationHours': parkingLotInfo.maxReservationHours,
      'availableRegularSpaces': parkingLotInfo.availableRegularSpaces,
      'availableElectricSpaces': parkingLotInfo.availableElectricSpaces,
      'regularSpacePrices': parkingLotInfo.availableRegularSpaces,
      'electricSpacePrices': parkingLotInfo.availableElectricSpaces
    };
  }

  static ParkingLotInfo deserialize(String json) =>
      ParkingLotInfo.fromJson(jsonDecode(json));
  static String serialize(ParkingLotInfo model) =>
      json.encode(ParkingLotInfo.toMap(model));
}
