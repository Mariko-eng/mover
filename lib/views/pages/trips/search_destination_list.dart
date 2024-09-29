import 'package:flutter/material.dart';
import 'package:bus_stop/models/destination/destination.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/controllers/authController.dart';
import 'package:bus_stop/views/widgets/app_bar_widget.dart';
import 'package:bus_stop/views/pages/trips/widgets/tripTile.dart';


class SearchDestinationListView extends StatefulWidget {
  final Destination fro;
  final Destination to;

  const SearchDestinationListView({super.key, required this.fro, required this.to});

  @override
  State<SearchDestinationListView> createState() => _SearchDestinationListViewState();
}

class _SearchDestinationListViewState extends State<SearchDestinationListView> {
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
                  print(snapshot.error);
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
                              Trip trip = trips[index];
                              return TripTile(
                                  client: userProvider.client!, trip: trip);
                            }),
                      ));
                }
              }),
        ],
      ),
    );
  }
}
