import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/views/pages/tickets/ticketTile.dart';
import 'package:bus_stop/views/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
// import 'package:bus_stop/views/v2/widgets/bottom_bar_widget.dart';
// import 'package:bus_stop/views/v2/drawer.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/controllers/authController.dart';

class HomeTicketView extends StatefulWidget {
  const HomeTicketView({super.key});

  @override
  State<HomeTicketView> createState() => _HomeTicketViewState();
}

class _HomeTicketViewState extends State<HomeTicketView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: buildHomeAppBar(
          scaffoldKey: scaffoldKey, context: context, title: "My Tickets"),
      // drawer: DrawerView(),
      body: userProvider.client == null
          ? Container()
          : Column(
              children: [
                StreamBuilder(
                    stream: getMyTickets(uid: userProvider.client!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      if (snapshot.hasData) {
                        List<TripTicket>? tripTickets = snapshot.data;
                        if (tripTickets!.isEmpty) {
                          return const Expanded(
                              child: Center(
                            child: Text("No Available Tickets"),
                          ));
                        }
                        return Expanded(
                          child: ListView.builder(
                              itemCount: tripTickets.length,
                              itemBuilder: (context, int index) {
                                return FutureBuilder(
                                  future: tripTickets[index].setTripData(context),
                                  // ignore: missing_return
                                  builder: (context, snapshot) {
                                    TripTicket? ticket = snapshot.data;
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        if (index == 0) {
                                          return Container();
                                        }
                                        return Container();
                                      case ConnectionState.none:
                                        return const Text(
                                          'No Tickets',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFFE4191D),
                                              fontSize: 20.0),
                                        );
                                      case ConnectionState.active:
                                        return const Text('Searching... ');
                                      case ConnectionState.done:
                                        return ticket == null ? Container() : TicketTile(
                                            client: userProvider.client!,
                                            tripTicket: ticket);
                                    }
                                  },
                                );
                              }),
                        );
                      } else {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    })
              ],
            ),

      //bottomNavigationBar: buildBottomAppBar(context: context, activeBar: 3),
    );
  }
}
