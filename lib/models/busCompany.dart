import 'package:bus_stop/models/parkLocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop/config/collections/index.dart';

final CollectionReference companiesCollection = AppCollections.companiesRef;

class BusCompany {
  String uid;
  String name;
  String email;
  String contactEmail;
  String phoneNumber;
  String hotLine;
  String logo;

  BusCompany(
      {required this.uid,
      required this.name,
      required this.email,
      required this.contactEmail,
      required this.phoneNumber,
      required this.hotLine,
      required this.logo});

  factory BusCompany.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return BusCompany(
      uid: snap.id,
      name: data["name"],
      email: data["email"],
      contactEmail: data["contactEmail"],
      phoneNumber: data["phoneNumber"],
      hotLine: data["hotLine"],
      logo: data["logo"],
    );
  }
}

Stream<List<BusCompany>> getAllBusCompanies() {
  return companiesCollection
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => BusCompany.fromSnapshot(doc)).toList();
  });
}

Stream<List<ParkLocations>> getBusCompanyDestinations({required String companyId}) {
  return companiesCollection
      .doc(companyId)
      .snapshots()
      .map((DocumentSnapshot snap) {
        Map map = snap.data() as Map<String,dynamic>;
        var doc = map["parksLocations"];
    List<ParkLocations> _result = [];
    if (doc != null) {
      if (doc.length > 0) {
        doc.forEach((element) {
          _result.add(ParkLocations.fromMap(element));
        });
      }
    }
    return _result;
  });
}

Future getBusCompanyProfile({required String userId}) async {
  try {
    var result = await companiesCollection
        .doc(userId)
        .get();
    return BusCompany.fromSnapshot(result);
  } catch (e) {
    return null;
  }
}
