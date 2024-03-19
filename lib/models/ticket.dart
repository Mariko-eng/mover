import 'package:bus_stop/models/notifications.dart';
import 'package:bus_stop/models/ticketHistory.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/config/collections/index.dart';

final CollectionReference tripsCollection = AppCollections.tripsRef;
final CollectionReference ticketsCollection = AppCollections.ticketsRef;
final CollectionReference clientsCollection = AppCollections.clientsRef;

class TripTicket {
  final String ticketId;
  final String departureLocation;
  final String arrivalLocation;
  final int numberOfTickets;
  final int total;
  final int amountPaid;
  final String ticketType;
  final String ticketNumber;
  final String userId;
  final String status;
  final bool success;
  final String transactionId;
  final DocumentReference tripRef;
  final Timestamp createdAt;
  Trip? trip;

  TripTicket(
      {required this.ticketId,
      required this.departureLocation,
      required this.arrivalLocation,
      required this.numberOfTickets,
      required this.total,
      required this.amountPaid,
      required this.tripRef,
      required this.ticketType,
      required this.ticketNumber,
      required this.userId,
      required this.status,
      required this.success,
      required this.transactionId,
      required this.createdAt});

  Future<TripTicket?> setTripData(BuildContext context) async {
    try {
      DocumentSnapshot snapshot = await tripRef.get();
      if (snapshot.exists) {
        trip = Trip.fromSnapshot(snapshot);
        return this;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  factory TripTicket.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    return TripTicket(
        ticketId: snapshot.id,
        departureLocation: data['departureLocation'],
        arrivalLocation: data['arrivalLocation'],
        numberOfTickets: data["numberOfTickets"] == null ? 0 : int.parse(data["numberOfTickets"].toString()),
        total: data["total"] == null ? 0 : int.parse(data["total"].toString()),
        amountPaid: data["amountPaid"] == null ? 0 : int.parse(data["amountPaid"].toString()),
        tripRef: data['trip'],
        ticketType: data['ticketType'] ?? "",
        ticketNumber: data['ticketNumber'] ?? "",
        userId: data['userId'] ?? "",
        status: data['status'] ?? "",
        success: data['success'] ?? true,
        transactionId: data['transactionId'] ?? "",
        createdAt: data['createdAt']);
  }
}

Future<bool> purchaseOrdinaryTicket(
    {required String preTicketId,
    required Client client,
    required Trip trip,
    required int numberOfTickets,
    required int total,
    required int amountPaid,
    required String status,
    required bool success,
    required String transactionId,
    required String txRef}) async {
  try {
    final data = {
      'preTicketId': preTicketId,
      'companyId': trip.companyData!['id'],
      'companyName': trip.companyData!['name'],
      'trip': tripsCollection.doc(trip.id),
      'tripId': trip.id,
      'departureLocationId': trip.departureLocationId,
      'departureLocation': trip.departureLocationName,
      'arrivalLocationId': trip.arrivalLocationId,
      'arrivalLocation': trip.arrivalLocationName,
      'numberOfTickets': numberOfTickets,
      'user': clientsCollection.doc(client.uid),
      'userId': client.uid,
      'userEmail': client.email,
      'total': total,
      'amountPaid': amountPaid,
      'ticketType': "Ordinary",
      'ticketNumber': "#" + transactionId,
      'paymentStatus': status,
      'paymentSuccessFul': success,
      'paymentTransactionId': transactionId,
      'paymentTxRef': txRef,
      'status': "pending",
      'noOfVerifications' : 0,
      'createdAt': DateTime.now(),
    };

    DocumentReference doc = await ticketsCollection.add(data);

    await addTicketHistory(
        ticketId: doc.id,
        status: "created",
        statusDesc: "Ticket Has Been Purchased");

    await addClientNotification(
      clientId: client.uid,
      busCompanyId: trip.companyData!['id'],
      title: "New Ordinary Ticket",
      body: "#" +
          transactionId +
          " Ordinary Ticket Has Been Purchased Successfully",
    );

    DocumentReference tripRef = tripsCollection.doc(trip.id);
    await tripRef
        .update({'occupiedSeats': FieldValue.increment(numberOfTickets)});
    return true;
  } catch (e) {
    print(e.toString());
    throw e.toString();
  }
}

Future<bool> purchaseVIPTicket(
    {required String preTicketId,
    required Client client,
    required Trip trip,
    required int numberOfTickets,
    required int total,
    required int amountPaid,
    required String status,
    required bool success,
    required String transactionId,
    required String txRef}) async {
  try {
    final data = {
      'preTicketId': preTicketId,
      'companyId': trip.companyData!['id'],
      'companyName': trip.companyData!['name'],
      'trip': tripsCollection.doc(trip.id),
      'tripId': trip.id,
      'departureLocationId': trip.departureLocationId,
      'departureLocation': trip.departureLocationName,
      'arrivalLocationId': trip.arrivalLocationId,
      'arrivalLocation': trip.arrivalLocationName,
      'numberOfTickets': numberOfTickets,
      'user': clientsCollection.doc(client.uid),
      'userId': client.uid,
      'userEmail': client.email,
      'total': total,
      'amountPaid': amountPaid,
      'ticketType': "VIP",
      'ticketNumber': "#" + transactionId,
      'paymentStatus': status,
      'paymentSuccessFul': success,
      'paymentTransactionId': transactionId,
      'paymentTxRef': txRef,
      'status': "pending",
      'noOfVerifications' : 0,
      'createdAt': DateTime.now(),
    };

    DocumentReference doc = await ticketsCollection.add(data);

    await addTicketHistory(
        ticketId: doc.id,
        status: "created",
        statusDesc: "Ticket Has Been Purchased");

    await addClientNotification(
      clientId: client.uid,
      busCompanyId: trip.companyData!['id'],
      title: "New VIP Ticket",
      body: "#" + transactionId + " VIP Ticket Has Been Purchased Successfully",
    );

    DocumentReference tripRef = tripsCollection.doc(trip.id);
    await tripRef
        .update({'occupiedSeats': FieldValue.increment(numberOfTickets)});
    return true;
  } catch (e) {
    print(e.toString());
    throw e.toString();
  }
}

Stream<List<TripTicket>> getMyTickets({required String uid}) {
  return ticketsCollection
      .where("userId", isEqualTo: uid)
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
  });
}

Stream<List<TripTicket>> getMyTicketsForBusCompany(
    {required String uid, required String companyId}) {
  return ticketsCollection
      .where("userId", isEqualTo: uid)
      .where("companyId", isEqualTo: companyId)
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
  });
}
