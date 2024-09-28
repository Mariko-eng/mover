import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bus_stop/config/collections/index.dart';

class Client {
  final String uid;
  final String username;
  final String email;
  final String phoneNumber;

  Client(
      {required this.uid,
      required this.username,
      required this.email,
      required this.phoneNumber});

  factory Client.fromSnapshot(DocumentSnapshot snapshot) {
    return Client(
        uid: snapshot.id,
        username: snapshot.get("username"),
        email: snapshot.get("email"),
        phoneNumber: snapshot.get("phoneNumber"));
  }
}

Future<bool> checkIfUserExists(String email) async {
  try {
    QuerySnapshot snap =
        await AppCollections().clientsRef.where("email", isEqualTo: email).get();
    if (snap.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e.toString());
    throw Exception(e.toString());
  }
}

Future<Client?> createProfile(
    {required String uid,
    required String email,
    required String phoneNumber,
    required String username}) async {
  try {
    await AppCollections().clientsRef.doc(uid).set(
        {'email': email, 'phoneNumber': phoneNumber, 'username': username});
    return Client(
        uid: uid, username: username, email: email, phoneNumber: phoneNumber);
  } catch (e) {
    print(e);
    return null;
  }
}

Future<Client> getProfile({required String uid}) async {
  try {
    DocumentSnapshot snap = await AppCollections().clientsRef.doc(uid).get();
    if (snap.exists) {
      Client currentClient = Client.fromSnapshot(snap);
      await updateToken(uid: uid);
      return currentClient;
    } else {
      throw "Client Record Not Found!";
    }
  } catch (e) {
    print(e.toString());
    throw e.toString();
  }
}

Future<void> updateToken({required String uid}) async {
  var fcm = FirebaseMessaging.instance;
  try {
    String? token = await fcm.getToken();
    await fcm.subscribeToTopic("client");
    if (token != null) {
      print("Token : " + token);
      await AppCollections().clientsRef.doc(uid).update({"token": token});
    }
  } catch (e) {
    print("Failed To Update FCM Token");
    print(e.toString());
  }
}
