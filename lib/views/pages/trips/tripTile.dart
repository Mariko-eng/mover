import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/views/pages/trips/tripDetails.dart';
import 'package:bus_stop/config/shared/utils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/user.dart';

class TripTile extends StatelessWidget {
  final Client client;
  final Trip trip;

  const TripTile({Key? key, required this.trip, required this.client})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(trip.isClosed) {
          return;
        }
        if (trip.tripType == "Ordinary") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TripDetails(
                        client: client,
                        trip: trip,
                        ticketChoice: "Ordinary",
                        ticketChoicePrice: trip.priceOrdinary,
                      )));
        } else {
          _openBottomSheet(context: context);
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                Text(
                  trip.departureLocationName,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  height: 1,
                  width: 20,
                  color: Colors.red[900],
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  trip.arrivalLocationName,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xfffdfdfd),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffED696C),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20))),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 25,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              width: 60,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    dateToTime(trip.departureTime),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    dateToTime(trip.arrivalTime),
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Color(0xffED696C),
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.white, width: 2)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 50,
                                      width: 3,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Color(0xffED696C),
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.white, width: 2)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 10, right: 5, top: 8),
                                    child: Text(
                                      trip.departureLocationName,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  // Container(height: 55,),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, bottom: 8, right: 5, top: 1),
                                    child: Text(
                                      trip.arrivalLocationName,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    trip.companyName != ""
                                        ? Text(
                                            trip.companyName,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          )
                                        : FutureBuilder(
                                            future:
                                                trip.setCompanyData(context),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return Text(
                                                  trip.companyData!['name'],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                );
                                              } else {
                                                return const Text(
                                                  "Bus Stop",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                );
                                              }
                                            }),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Color(0xfffdfdfd),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Color(0xfffdfdfd),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50))),
                      ),
                    ),
                    Positioned(
                        top: 8,
                        right: 15,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                trip.busPlateNo == ""
                                    ? Container()
                                    : Text(
                                  trip.busPlateNo.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900]),
                                ),
                                trip.busPlateNo == ""
                                    ? Container()
                                    :
                                Text(" ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[900])),
                              ],
                            ),
                            Text(
                              dateToStringNew(trip.departureTime),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                  ],
                )),
            Container(
              width: 350,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xffED696C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  const DottedLine(
                    dashColor: Colors.white,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                          color: Color(0xfffdfdfd),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                          color: Color(0xfffdfdfd),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50))),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: trip.tripType == "Ordinary"
                        ? Container(
                            width: 200,
                            height: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: trip.discountPriceOrdinary == 0
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceBetween,
                              children: [
                                if (trip.discountPriceOrdinary != 0)
                                  RichText(
                                    text: TextSpan(
                                      text: trip.priceOrdinary
                                              .toString() +
                                          " SHS",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.red[800],
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ),
                                RichText(
                                  text: TextSpan(
                                      text: trip.discountPriceOrdinary.toString() +
                                          " SHS",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue[800])),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: 250,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: trip.discountPriceOrdinary == 0
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: "ORDINARY",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue[800]),
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: trip.priceOrdinary
                                                          .toString() +
                                                      " SHS",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blue[800])),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: "ORDINARY",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue[800]),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: trip.priceOrdinary
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Colors.red[800],
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                      text: trip
                                                              .discountPriceOrdinary
                                                              .toString() +
                                                          " SHS",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .blue[800])),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: trip.discountPriceVip == 0
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: "VIP",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue[800]),
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text:
                                                      trip.priceVip.toString() +
                                                          " SHS",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blue[800])),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: "VIP",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue[800]),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: trip.priceVip
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Colors.red[800],
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                      text: trip
                                                              .discountPriceVip
                                                              .toString() +
                                                          " SHS",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .blue[800])),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                ),
                              ],
                            )),
                  ),

                  Visibility(
                    visible: trip.isClosed,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                          color: Colors.black,
                          child: Text("ClOSED",
                          style: TextStyle(
                            color: Colors.white
                          ),
                          )),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _openBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getTicketOptions(context);
        });
  }

  Widget _getTicketOptions(BuildContext context) {
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
                              builder: (context) => TripDetails(
                                    client: client,
                                    trip: trip,
                                    ticketChoice: "Ordinary",
                                    ticketChoicePrice:
                                        trip.discountPriceOrdinary == 0
                                            ? trip.priceOrdinary
                                            : trip.discountPriceOrdinary,
                                  )));
                    }
                    if (option == "Buy VIP Ticket") {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TripDetails(
                                    client: client,
                                    trip: trip,
                                    ticketChoice: "VIP",
                                    ticketChoicePrice:
                                        trip.discountPriceVip == 0
                                            ? trip.priceVip
                                            : trip.discountPriceVip,
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
