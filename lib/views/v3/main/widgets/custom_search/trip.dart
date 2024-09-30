import 'package:flutter/material.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';
import 'package:bus_stop/views/v3/main/widgets/trip_widget.dart';
import 'package:bus_stop/views/v3/pages/payment.dart';

class CustomSearchTripWidget extends SearchDelegate {
  // List<Trip> searchTerms;

  // CustomSearchTripWidget(
  //     {required this.searchTerms});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder(
        future: fetchActiveTrips(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "Something Went Wrong!",
                  style: textTheme.bodyMedium!
                      .copyWith(color: Colors.black, fontSize: 15),
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Container(
                color: Colors.white,
                child: const Center(child: LoadingWidget()));
          }

          List<Trip>? trips = snapshot.data;

          if (trips == null) {
            return Container(
                color: Colors.white,
                child: const Center(child: LoadingWidget()));
          }

          List<Trip> matches = [];

          for (var item in trips) {
            if (item.companyName.toLowerCase().contains(query.toLowerCase()) ||
                item.arrivalLocationName
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                item.departureLocationName
                    .toLowerCase()
                    .contains(query.toLowerCase())) {
              matches.add(item);
            }
          }

          return Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                      onTap: () {
                        if (matches[index].isClosed) {
                          return;
                        }
                        if (matches[index].tripType == "Ordinary") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentView(
                                        trip: matches[index],
                                        ticketChoice: "Ordinary",
                                        ticketChoicePrice:
                                            matches[index].priceOrdinary,
                                      )));
                        } else {
                          _openBottomSheet(
                              context: context, trip: matches[index]);
                        }
                      },
                      child: TripWidget(trip: matches[index]));
                }),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder(
        future: fetchActiveTrips(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "Something Went Wrong!",
                  style: textTheme.bodyMedium!
                      .copyWith(color: Colors.black, fontSize: 15),
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Container(
                color: Colors.white,
                child: const Center(child: LoadingWidget()));
          }

          List<Trip>? trips = snapshot.data;

          if (trips == null) {
            return Container(
                color: Colors.white,
                child: const Center(child: LoadingWidget()));
          }

          List<Trip> matches = [];

          for (var item in trips) {
            if (item.companyName.toLowerCase().contains(query.toLowerCase()) ||
                item.arrivalLocationName
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                item.departureLocationName
                    .toLowerCase()
                    .contains(query.toLowerCase())) {
              matches.add(item);
            }
          }

          return Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                      onTap: () {
                        if (matches[index].isClosed) {
                          return;
                        }
                        if (matches[index].tripType == "Ordinary") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentView(
                                        trip: matches[index],
                                        ticketChoice: "Ordinary",
                                        ticketChoicePrice: matches[index]
                                                    .discountPriceOrdinary >
                                                0
                                            ? matches[index]
                                                .discountPriceOrdinary
                                            : matches[index].priceOrdinary,
                                      )));
                        } else {
                          _openBottomSheet(
                              context: context, trip: matches[index]);
                        }
                      },
                      child: TripWidget(trip: matches[index]));
                }),
          );
        });
  }

  void _openBottomSheet({required BuildContext context, required Trip trip}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getTicketOptions(context, trip);
        });
  }

  Widget _getTicketOptions(BuildContext context, Trip trip) {
    final options = [
      "Buy Ordinary Ticket",
      "Buy VIP Ticket",
    ];
    return Container(
      height: 150,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) => ListTile(
                  onTap: () async {
                    if (option == "Buy Ordinary Ticket") {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentView(
                                    trip: trip,
                                    ticketChoice: "Ordinary",
                                    ticketChoicePrice:
                                        trip.discountPriceOrdinary > 0
                                            ? trip.discountPriceOrdinary
                                            : trip.priceOrdinary,
                                  )));
                    }
                    if (option == "Buy VIP Ticket") {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentView(
                                    trip: trip,
                                    ticketChoice: "VIP",
                                    ticketChoicePrice: trip.discountPriceVip > 0
                                        ? trip.discountPriceVip
                                        : trip.priceVip,
                                  )));
                    }
                  },
                  title: Column(
                    children: [
                      Text(
                        option,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Color(0xFFE4191D)),
                      ),
                      SizedBox(height: 4),
                      Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
