import 'package:bus_stop/config/collections/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final CollectionReference tripsCollection = AppCollections.tripsRef;

class Trip {
  final String id;
  // final DocumentReference arrivalLocation;
  final String arrivalLocationId;
  final String arrivalLocationName;
  // final DocumentReference departureLocation;
  final String departureLocationId;
  final String departureLocationName;
  final String companyId;
  final DocumentReference company;
  final String busPlateNo;
  final DateTime arrivalTime;
  final DateTime departureTime;
  final int totalSeats;
  final int occupiedSeats;
  final int discountPrice;
  final int discountPriceOrdinary;
  final int discountPriceVip;
  final int totalOrdinarySeats;
  final int occupiedOrdinarySeats;
  final int price;
  final int priceOrdinary;
  final int priceVip;
  final int totalVipSeats;
  final int occupiedVipSeats;
  final String tripNumber;
  final String tripType;
  Map<String, dynamic>? companyData;

  // Map<String, dynamic>? arrival;
  // Map<String, dynamic>? departure;

  Trip(
      {required this.id,
      required this.arrivalLocationId,
      required this.arrivalLocationName,
      required this.departureLocationId,
      required this.departureLocationName,
      required this.company,
      required this.companyId,
        required  this.busPlateNo,
        required this.departureTime,
      required this.arrivalTime,
      required this.totalSeats,
      required this.occupiedSeats,
      required this.price,
      required this.discountPrice,
      required this.totalOrdinarySeats,
      required this.occupiedOrdinarySeats,
      required this.priceOrdinary,
      required this.discountPriceOrdinary,
      required this.totalVipSeats,
      required this.occupiedVipSeats,
      required this.priceVip,
      required this.discountPriceVip,
      required this.tripNumber,
      required this.tripType});

  Future<Trip> setCompanyData(BuildContext context) async {
    // print(company);
    DocumentSnapshot companySnapshot = await company.get();
    // print(companySnapshot.id);
    // print(companySnapshot.get("name"));
    Map<String, dynamic> companyMap =
        companySnapshot.data() as Map<String, dynamic>;
    companyData = {'id': companySnapshot.id}..addAll(companyMap);

    // DocumentSnapshot arrivalSnapshot = await arrivalLocation.get();
    // Map<String,dynamic> arrivalData = arrivalSnapshot.data() as Map<String,dynamic>;
    // arrival = {'id': arrivalSnapshot.id}..addAll(arrivalData);
    //
    // DocumentSnapshot departureSnapshot = await departureLocation.get();
    // Map<String,dynamic> departureData = departureSnapshot.data() as Map<String,dynamic>;
    // departure = {'id': departureSnapshot.id}..addAll(departureData);

    return this;
  }

  factory Trip.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    return Trip(
        id: snapshot.id,
        arrivalLocationId: data['arrivalLocationId'] ?? "",
        arrivalLocationName: data['arrivalLocationName'] ?? "",
        departureLocationId: data['departureLocationId'] ?? "",
        departureLocationName: data['departureLocationName'] ?? "",
        company: data['company'],
        companyId: data['companyId'] ?? "",
        busPlateNo: data['busPlateNo'] ?? "",
        departureTime: data['departureTime'].toDate(),
        arrivalTime: data['arrivalTime'].toDate(),
        totalSeats: data['totalSeats'] ?? 0,
        occupiedSeats: data['occupiedSeats'] ?? 0,
        price: data['price'] ?? 0,
        discountPrice: data['discountPrice'] ?? data['price'] ?? 0,
        totalOrdinarySeats: data['totalOrdinarySeats'] ?? 0,
        occupiedOrdinarySeats: data['occupiedOrdinarySeats'] ?? 0,
        priceOrdinary: data['priceOrdinary'] ?? 0,
        discountPriceOrdinary:
            data['discountPriceOrdinary'] ?? data['priceOrdinary'] ?? 0,
        totalVipSeats: data['totalVipSeats'] ?? 0,
        occupiedVipSeats: data['occupiedVipSeats'] ?? 0,
        priceVip: data['priceVip'] ?? 0,
        discountPriceVip: data['discountPriceVip'] ?? data['priceVip'] ?? 0,
        tripNumber: data['tripNumber'] ?? "",
        tripType: data['tripType'] ?? "");
  }
}

Stream<List<Trip>> getAllActiveTrips() {
  DateTime now = DateTime.now();
  DateTime yesterday =
  DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

  return tripsCollection
      .where('departureTime', isGreaterThanOrEqualTo: yesterday)
      .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Stream<List<Trip>> getAllTripsForBusCompany({required String companyId}) {
  DateTime now = DateTime.now();
  DateTime yesterday =
      DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

  return tripsCollection
      .where('companyId', isEqualTo: companyId)
      .where('departureTime', isGreaterThanOrEqualTo: yesterday)
      // .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Future<List<Trip>> searchForTrips(
    {required String fromDestId, required String toDestId}) async {
  DateTime now = DateTime.now();
  DateTime yesterday =
      DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

  QuerySnapshot snapshot = await tripsCollection
      .where('departureTime', isGreaterThan: yesterday)
      .where('departureLocationId', isEqualTo: fromDestId.trim())
      .where('arrivalLocationId', isEqualTo: toDestId.trim())
      .get();
  return snapshot.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
}
