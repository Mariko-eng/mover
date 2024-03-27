import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/pages/tickets/ticketsList.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/busCompany.dart';
import 'package:provider/provider.dart';

class BusCompanyMyTickets extends StatefulWidget {
  final BusCompany company;
  final Client client;
  const BusCompanyMyTickets({Key? key,required this.company,required this.client}) : super(key: key);

  @override
  _BusCompanyMyTicketsState createState() => _BusCompanyMyTicketsState();
}

class _BusCompanyMyTicketsState extends State<BusCompanyMyTickets> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TripTicket>>.value(
      initialData: const [],
      value: getMyTicketsForBusCompany(uid: widget.client.uid,companyId: widget.company.uid),
      child : TripsTicketList(client: widget.client,),
    );
  }
}
