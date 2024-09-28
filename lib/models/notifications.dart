import 'package:bus_stop/config/collections/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications{
  String id;
  String clientId;
  String busCompanyId;
  String title;
  String body;
  bool isClientBased;
  DateTime dateCreated;

  Notifications({
    required this.id,
    required this.clientId,
    required this.busCompanyId,
    required this.title,
    required this.body,
    required this.isClientBased,
    required this.dateCreated
  });

  factory Notifications.fromSnapshot(DocumentSnapshot snapshot){
    Map data = snapshot.data() as Map;
    return Notifications(
      id: snapshot.id,
      clientId: data["clientId"],
      busCompanyId: data["busCompanyId"],
      title: data["title"],
      body: data["body"],
      isClientBased: data["isClientBased"],
      dateCreated: data["dateCreated"].toDate(),
    );
  }
}

Future<bool> addClientNotification({
  required String clientId,
  required String busCompanyId,
  required String title,
  required String body,
}) async{
  DateTime nw = DateTime.now();
  try{
    await AppCollections().notificationsRef.add({
      "clientId":clientId,
      "busCompanyId":busCompanyId,
      "title":title,
      "body":body,
      "isClientBased": true,
      "dateCreated": nw
    });
    return true;
  }catch(e){
    return false;
  }
}


