import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/views/travel/ticketsList.dart';
import 'package:bus_stop/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/models/user.dart';

class TripTickets extends StatefulWidget {
  final Client client;
  const TripTickets({Key? key,required this.client}) : super(key: key);

  @override
  _TripTicketsState createState() => _TripTicketsState();
}

class _TripTicketsState extends State<TripTickets> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TripTicket>>.value(
      initialData: const [],
      value: getMyTickets(uid: widget.client.uid),
      // Firestore(uid: uid).tripTickets,
      child : TripsTicketList(client: widget.client,),
    );
  }
}
