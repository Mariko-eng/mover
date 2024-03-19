import 'package:cloud_firestore/cloud_firestore.dart';

class AppProfileSettings {
  String email1;
  String email2;
  String phone1;
  String phone2;
  String hotline1;
  String hotline2;

  AppProfileSettings(
      {required this.email1,
        required this.email2,
        required this.phone1,
        required this.phone2,
        required this.hotline1,
        required this.hotline2});

  factory AppProfileSettings.fromSnap(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    return AppProfileSettings(
      email1: data["email1"],
      email2: data["email2"],
      phone1: data["phone1"],
      phone2: data["phone2"],
      hotline1: data["hotline1"],
      hotline2: data["hotline2"],
    );
  }
}

Future<AppProfileSettings?> appProfileSettings() async {
  try {
    var result = await FirebaseFirestore.instance
        .collection("appSettings")
        .doc("bus_stop")
        .get();
    return AppProfileSettings.fromSnap(result);
  } catch (e) {
    return null;
  }
}