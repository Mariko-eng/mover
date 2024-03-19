import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/views/travel/tripTile.dart';
import 'package:bus_stop/views/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/user.dart';

class Trips extends StatefulWidget {
  final Client client;
  final List<Trip> trips;
  const Trips({Key? key,required this.client ,required this.trips})  : super(key: key);

  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  Widget build(BuildContext context) {
    return widget.trips.isEmpty
        ? Scaffold(
      backgroundColor: Color(0xfffdfdfd),
      appBar: AppBar(
        backgroundColor: Color(0xfffdfdfd),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              width: 20,height: 25,
              child: Image.asset('assets/images/back_arrow.png',)),
        ),
        title:
        Text("Trips - Travel".toUpperCase(),
          style: TextStyle(color: Colors.red[900]),),
      ),
      body: const Center(
          child: Text(
            "No Available trips!",
            style: TextStyle(
                color: Color(
                  0xffE4181D,
                ),
                fontSize: 20.0),
          )),
    )
        : Scaffold(
        backgroundColor: Color(0xfffdfdfd),
        appBar: AppBar(
          backgroundColor: Color(0xfffdfdfd),
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
                width: 20,height: 25,
                child: Image.asset('assets/images/back_arrow.png',)),
          ),
        ),
        body: ListView.builder(
          itemCount: widget.trips.length,
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: widget.trips[index].setCompanyData(context),
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
            );
          },
        ));
  }
}
