import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/shared/loading.dart';
import 'package:bus_stop/views/travel/tripTile.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/busCompany.dart';

class BusCompanyTrips extends StatefulWidget {
  final BusCompany company;
  final Client client;
  const BusCompanyTrips({Key? key,required this.company,required this.client}) : super(key: key);

  @override
  _BusCompanyTripsState createState() => _BusCompanyTripsState();
}

class _BusCompanyTripsState extends State<BusCompanyTrips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          iconTheme: const IconThemeData(color: Color(0xff62020a)),
          title: Text(
            widget.company.name + " Trips".toUpperCase(),
            style: const TextStyle(color: Color(0xff62020a)),
          )),
      body: StreamBuilder(
        stream: getAllTripsForBusCompany(companyId: widget.company.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            List<Trip>? trips = snapshot.data;
            if(trips!.isEmpty){
              return Center(
                child: Text("No Available Trips!".toUpperCase(),
                  style: const TextStyle(
                      color: Color(0xff62020a)
                  ),
                ),
              );
            }
            return ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, int index) => FutureBuilder(
                  future: trips[index].setCompanyData(context),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    final trip = snapshot.data;

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        if (index == 0) {
                          return Loading();
                        }

                        return Container();
                      case ConnectionState.none:
                        return const Text(
                          'No Trips',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFFE4191D), fontSize: 20.0),
                        );
                      case ConnectionState.active:
                        return const Text('Searching... ');
                      case ConnectionState.done:
                        return TripTile(client: widget.client, trip: trip!);
                    }
                  },
                )
            );
          }
          return Container();
        },
      ),
    );
  }
}
