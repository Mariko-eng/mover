import 'package:bus_stop/models/destination.dart';
import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/travel/searchTrip.dart';
import 'package:bus_stop/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTravel extends StatefulWidget {
  final Client client;
  const HomeTravel({required this.client, Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeTravel> {
  Firestore fireStore = Firestore();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Destination>>.value(
      initialData: const [],
      value: fireStore.destinations,
      child: SearchTrip(client: widget.client,),
    );
  }
}
