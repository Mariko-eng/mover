// import 'package:bus_stop/models/destination/destination.dart';
// import 'package:bus_stop/models/trip.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:bus_stop/config/collections/index.dart';
//
// class Firestore {
//   final String? uid;
//   Firestore({this.uid});
//
//   final CollectionReference clientProfile = AppCollections.clientsRef;
//   final CollectionReference tripsCollection = AppCollections.tripsRef;
//   final CollectionReference destinationsCollection =
//       AppCollections.destinationsRef;
//   final CollectionReference ticketsCollection = AppCollections.ticketsRef;
//
//   Future createProfile(
//       String email, String phoneNumber, String username) async {
//     return await clientProfile.doc(uid).set(
//         {'email': email, 'phoneNumber': phoneNumber, 'username': username});
//   }
//
//   List<Destination> _destinationListFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.docs.map((doc) {
//       return Destination(id: doc.id, name: doc.get('name'));
//     }).toList();
//   }
//
//   Stream<List<Destination>> get destinations {
//     return destinationsCollection
//         .orderBy('name')
//         .snapshots()
//         .map(_destinationListFromSnapshot);
//   }
//
//   Future<List<Trip>> searchTrips(
//       String departureLocation, String arrivalLocation) async {
//     DateTime now = DateTime.now();
//     DateTime yesterday =
//         DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);
//
//     QuerySnapshot snapshot = await tripsCollection
//         .where('departureTime', isGreaterThan: yesterday)
//         .where('arrivalLocationId', isEqualTo: arrivalLocation.trim())
//         .where('departureLocationId', isEqualTo: departureLocation.trim())
//         .get();
//     return snapshot.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
//   }
// }
