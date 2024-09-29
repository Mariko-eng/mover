import 'package:bus_stop/models/destination/destination.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/views/v3/main/widgets/trip_widget.dart';
import 'package:bus_stop/views/v3/pages/payment.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripsSearchView extends StatefulWidget {
  final Destination fro;
  final Destination to;
  final String busCompanyId;

  const TripsSearchView(
      {super.key,
      required this.fro,
      required this.to,
      required this.busCompanyId});

  @override
  State<TripsSearchView> createState() => _TripsSearchViewState();
}

class _TripsSearchViewState extends State<TripsSearchView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.fro.name} to ${widget.to.name}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              // Text("20th July 2024",
              //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //       fontSize: 18,
              //       fontWeight: FontWeight.w400,
              //       color: Colors.black
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: searchTrips(
                      fromDestId: widget.fro.id,
                      toDestId: widget.to.id,
                      companyId: widget.busCompanyId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Something Went Wrong!",
                          style: textTheme.bodyMedium!
                              .copyWith(color: Colors.black, fontSize: 15),
                        ),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: LoadingWidget());
                    }

                    List<Trip>? data = snapshot.data;

                    if (data == null) {
                      return const Center(child: LoadingWidget());
                    }

                    if (data.isEmpty) {
                      return Center(
                        child: Text(
                          "No Trips At The Moment!",
                          style: textTheme.bodyMedium!
                              .copyWith(color: Colors.black, fontSize: 15),
                        ),
                      );
                    }

                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, int index) {
                          return GestureDetector(
                            onTap: () {
                              if (data[index].isClosed) {
                                return;
                              }
                              if (data[index].tripType == "Ordinary") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentView(
                                              trip: data[index],
                                              ticketChoice: "Ordinary",
                                              ticketChoicePrice: data[index]
                                                          .discountPriceOrdinary >
                                                      0
                                                  ? data[index]
                                                      .discountPriceOrdinary
                                                  : data[index].priceOrdinary,
                                            )));
                              } else {
                                _openBottomSheet(
                                    context: context, trip: data[index]);
                              }
                            },
                            child: TripWidget(trip: data[index]),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
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
