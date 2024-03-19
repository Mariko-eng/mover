import 'package:bus_stop/config/collections/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final CollectionReference tripTicketHistoryCollection = AppCollections.ticketsHistoryRef;

class TicketHistory{
  final String id;
  final String ticketId;
  final String status;
  final String statusDesc;
  final String createdBy;
  final Timestamp createdAt;

  TicketHistory(
      {required this.id,
        required this.ticketId,
        required this.status,
        required this.statusDesc,
        required this.createdBy,
        required this.createdAt,
      });
}

Future<String> addTicketHistory(
    {
      required String ticketId,
      required String status,
      required String statusDesc,
    }) async {
  try {
    final data = {
      'ticketId': ticketId,
      'status': status,
      'statusDesc': statusDesc,
      'createdBy': FirebaseAuth.instance.currentUser!.uid,
      'createdAt': DateTime.now(),
    };

    DocumentReference doc = await tripTicketHistoryCollection.add(data);
    return doc.id;
  } catch (e) {
    print(e.toString());
    throw Exception(e.toString());
  }
}

