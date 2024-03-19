import 'package:flutter/material.dart';
import 'package:bus_stop/models/destination.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/contollers/authController.dart';
import 'package:bus_stop/views/v2/widgets/app_bar_widget.dart';
import 'package:bus_stop/views/travel/tripTile.dart';


class TripSearchListView extends StatefulWidget {
  final Destination fro;
  final Destination to;

  const TripSearchListView({super.key, required this.fro, required this.to});

  @override
  State<TripSearchListView> createState() => _TripSearchListViewState();
}

class _TripSearchListViewState extends State<TripSearchListView> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: buildTopAppBar(
          context: context, title: widget.fro.name + " - " + widget.to.name),
      body: userProvider.client == null
          ? Container()
          : Column(
              children: [
                FutureBuilder(
                    future: searchForTrips(
                        fromDestId: widget.fro.id, toDestId: widget.to.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Expanded(
                            child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Something has Gone Wrong!"),
                            ],
                          ),
                        ));
                      }
                      if (!snapshot.hasData) {
                        return const Expanded(
                            child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ));
                      } else {
                        List<Trip>? trips = snapshot.data;
                        if (trips!.isEmpty) {
                          return Expanded(
                              child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("No Available Trips"),
                              ],
                            ),
                          ));
                        }
                        return Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.builder(
                              itemCount: trips.length,
                              itemBuilder: (context, int index) {
                                return FutureBuilder(
                                  future: trips[index].setCompanyData(context),
                                  // ignore: missing_return
                                  builder: (context, snapshot) {
                                    final trip = snapshot.data;

                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        if (index == 0) {
                                          return const CircularProgressIndicator();
                                        }
                                        return Container();
                                      case ConnectionState.none:
                                        return const Text(
                                          'No Trips',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFFE4191D),
                                              fontSize: 20.0),
                                        );
                                      case ConnectionState.active:
                                        return const Text('Searching... ');
                                      case ConnectionState.done:
                                        return TripTile(
                                            client: userProvider.client!,
                                            trip: trip!);
                                    }
                                  },
                                );
                              }),
                        ));
                      }
                    }),
              ],
            ),
    );
  }
}
