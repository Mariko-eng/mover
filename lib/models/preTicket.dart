import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop/config/collections/index.dart';

final CollectionReference preTripTicketCollection =
    AppCollections.ticketsPreRef;

class PreTripTicket {
  final String id;
  final String companyId;
  final String companyName;
  final String tripId;
  final String departureLocationId;
  final String departureLocationName;
  final String arrivalLocationId;
  final String arrivalLocationName;
  final String ticketType;
  final int numberOfTickets;
  final int ticketPrice;
  final int totalAmount;
  final String clientId;
  final String clientUsername;
  final Timestamp createdAt;

  PreTripTicket(
      {required this.id,
      required this.companyId,
      required this.companyName,
      required this.tripId,
      required this.departureLocationId,
      required this.departureLocationName,
      required this.arrivalLocationId,
      required this.arrivalLocationName,
      required this.ticketType,
      required this.numberOfTickets,
      required this.ticketPrice,
      required this.totalAmount,
      required this.clientId,
      required this.clientUsername,
      required this.createdAt});
}

Future<String> addPreTripTicketData({
  required Client client,
  required Trip trip,
  required String ticketType,
  required int ticketPrice,
  required int numberOfTickets,
  required int totalAmount,
}) async {
  try {
    final data = {
      'companyId': trip.companyData!['id'],
      'companyName': trip.companyData!['name'],
      'tripId': trip.id,
      'arrivalLocationId': trip.arrivalLocationId,
      'arrivalLocationName': trip.arrivalLocationName,
      'departureLocationId': trip.departureLocationId,
      'departureLocationName': trip.departureLocationName,
      'ticketType': ticketType,
      'numberOfTickets': numberOfTickets,
      'ticketPrice': ticketPrice,
      'totalAmount': totalAmount,
      'isCompleted': false,
      'userId': client.uid,
      'userEmail': client.email,
      'createdAt': DateTime.now(),
    };

    DocumentReference doc = await preTripTicketCollection.add(data);
    return doc.id;
  } catch (e) {
    print(e.toString());
    throw Exception(e.toString());
  }
}
