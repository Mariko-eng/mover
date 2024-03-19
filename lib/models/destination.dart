import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop/config/collections/index.dart';

final CollectionReference destinationsCollection = AppCollections.destinationsRef;

class Destination {
  final String id;
  final String name;

  Destination({required this.id, required this.name});
}

List<Destination> _destinationListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return Destination(id: doc.id, name: doc.get('name'));
  }).toList();
}

Stream<List<Destination>> getDestinations() {
  return destinationsCollection
      .orderBy('name')
      .snapshots()
      .map(_destinationListFromSnapshot);
}
