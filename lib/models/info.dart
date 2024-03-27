import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bus_stop/config/collections/index.dart';

class InfoModel {
  final String id;
  final String title;
  final String subTitle;
  final String imageUrl;
  final String description;
  final String busCompanyId;
  final String busCompanyName;


  InfoModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.description,
    required this.busCompanyId,
    required this.busCompanyName,
  });

  factory InfoModel.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data() as Map;
    return InfoModel(
      id: snap.id,
      title: data["title"] ?? "",
      subTitle: data["subTitle"] ?? "",
      imageUrl: data["imageUrl"] ?? "",
      description: data["description"] ?? "",
      busCompanyId: data["busCompanyId"] ?? "",
      busCompanyName: data["busCompanyName"] ?? "",
    );
  }
}

Stream<List<InfoModel>> getAllInfo() {
  return AppCollections.infoRef.snapshots().map((snap) {
    return snap.docs.map((doc) => InfoModel.fromSnapshot(doc)).toList();
  });
}