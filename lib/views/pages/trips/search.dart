import 'package:bus_stop/controllers/authController.dart';
import 'package:bus_stop/controllers/locController.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/views/pages/trips/widgets/searchTripTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AllTripsSearchView extends StatefulWidget {
  final bool isSearching;
  final Function setIsSearching;

  const AllTripsSearchView(
      {super.key, required this.isSearching, required this.setIsSearching});

  @override
  State<AllTripsSearchView> createState() => _AllTripsSearchViewState();
}

class _AllTripsSearchViewState extends State<AllTripsSearchView> {
  LocationController controller = Get.find();

  final TextEditingController _searchCtr = TextEditingController();
  String searchString = "";

  bool isSearching = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    // controller.activeTrips();

    List<Trip> trips = controller.trips;

    return userProvider.client == null
        ? Column(
            children: [
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          )
        : Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: _searchCtr,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  widget.setIsSearching();
                                },
                                child: Icon(Icons.close)),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (String val) {
                            setState(() {
                              searchString = val.toLowerCase();
                            });
                          },
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Builder(builder: (context) {
                      if (isSearching) {
                        // State when fetching the data
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Container()],
                        );
                      }
                      if (trips.isEmpty) {
                        return Expanded(
                            child: Center(
                          child: Container(),
                        ));
                      }

                      final results = _search(trips);

                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: ListView.builder(
                                    itemCount: results.length,
                                    itemBuilder: (context, int index) {
                                      return SearchTripTile(
                                          client: userProvider.client!,
                                          trip: results[index]);
                                    })),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          );
  }

  List<Trip> _search(List<Trip>? data) {
    if (searchString.isNotEmpty == true) {
      //search logic what you want
      return data
              ?.where((element) => "${element.departureLocationName}"
                      "${element.arrivalLocationName}"
                  .toLowerCase()
                  .contains(searchString))
              .toList() ??
          <Trip>[];
    }
    return data ?? <Trip>[];
  }
}
