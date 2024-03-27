import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop/config/collections/index.dart';
import 'package:bus_stop/models/destination/locationModel.dart';

final CollectionReference destinationsCollection = AppCollections.destinationsRef;

class Destination {
  final String id;
  final String name;
  final LocationDetailsModel? locationDetails;

  Destination({required this.id, required this.name, this.locationDetails});

  factory Destination.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return Destination(
        id: snap.id,
        name: data["name"] ?? "",
        locationDetails: data["locationDetails"] == null
            ? null
            : LocationDetailsModel.fromJson(data["locationDetails"]));
  }
}

List<Destination> _destinationListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return Destination.fromSnapshot(doc);
  }).toList();
}

Stream<List<Destination>> getDestinations() {
  return destinationsCollection
      .orderBy('name')
      .snapshots()
      .map(_destinationListFromSnapshot);

}

Future<List<Destination>> fetchDestinations() async {
  try{
    var results = await destinationsCollection.orderBy('name').get();
    return _destinationListFromSnapshot(results);
  }catch(e){
    throw(e.toString());
  }
}
