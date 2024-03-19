import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/views/travel/tripTile.dart';
// import 'package:bus_stop/views/v2/drawer.dart';
import 'package:bus_stop/views/v2/widgets/bottom_bar_widget.dart';
import 'package:bus_stop/views/v2/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/contollers/authController.dart';

class HomeAllTripsView extends StatefulWidget {
  const HomeAllTripsView({super.key});

  @override
  State<HomeAllTripsView> createState() => _HomeAllTripsViewState();
}

class _HomeAllTripsViewState extends State<HomeAllTripsView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: buildHomeAppBar(
          scaffoldKey: scaffoldKey, context: context, title: "Trips"),
      // drawer: const DrawerView(),
      body: userProvider.client == null
          ? Container()
          : Column(
              children: [
                StreamBuilder(
                    stream: getAllActiveTrips(),
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
                        // return Container();
                        return Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.builder(
                              itemCount: trips!.length,
                              itemBuilder: (context, int index) {
                                return FutureBuilder(
                                  future: trips[index].setCompanyData(context),
                                  // ignore: missing_return
                                  builder: (context, snapshot) {
                                    final trip = snapshot.data;

                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        if (index == 0) {
                                          // return const CircularProgressIndicator();
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
                                        return trip == null
                                            ? Container()
                                            : TripTile(
                                                client: userProvider.client!,
                                                trip: trip);
                                    }
                                  },
                                );
                              }),
                        ));
                      }
                    }),
              ],
            ),
      bottomNavigationBar: buildBottomAppBar(context: context, activeBar: 1),
    );
  }
}
