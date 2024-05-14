import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/pages/tickets/ticketTile.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class TransactionTickets extends StatefulWidget {
  final String transactionId;
  final Client client;
  const TransactionTickets({super.key, required this.transactionId, required this.client});

  @override
  State<TransactionTickets> createState() => _TransactionTicketsState();
}

class _TransactionTicketsState extends State<TransactionTickets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdfdfd),
      appBar: AppBar(
        backgroundColor: Color(0xfffdfdfd),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Tickets",
          style: TextStyle(color: Color(0xffE4181D)),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              width: 20,
              height: 25,
              child: Image.asset(
                'assets/images/back_arrow.png',
              )),
        ),
      ),
      body: StreamBuilder(
        stream: getTransactionTickets(transactionId: widget.transactionId),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            print(snapshot.error);
          }
          if(!snapshot.hasData) {
            return LoadingWidget();
          }else{
            List<TripTicket>? tickets = snapshot.data;
            return tickets!.isEmpty
                ? const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'No tickets',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFE4191D),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
                : ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {

                return FutureBuilder(
                  future: tickets[index].setTripData(context),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    TripTicket? ticket = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        if (index == 0) {
                          return LoadingWidget();
                        }
                        return Container();
                      case ConnectionState.none:
                        return Container(
                          child: const Text(
                            'No Tickets',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFFE4191D), fontSize: 20.0),
                          ),
                        );
                      case ConnectionState.active:
                        return Text('Searching... ');
                      case ConnectionState.done:
                        return TicketTile(
                            client: widget.client, tripTicket: ticket!);
                    }
                  },
                );
              },
            );
          }
        },
      )
    );
  }
}
