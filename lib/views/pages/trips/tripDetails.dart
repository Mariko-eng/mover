import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/pages/payment/TicketNewPayment.dart';
import 'package:bus_stop/config/shared/utils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TripDetails extends StatefulWidget {
  final Client client;
  final Trip trip;
  final String ticketChoice;
  final int ticketChoicePrice;

  const TripDetails(
      {Key? key,
      required this.client,
      required this.trip,
      required this.ticketChoice,
      required this.ticketChoicePrice})
      : super(key: key);

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  TextEditingController noOfTicketsController = TextEditingController();
  int noOfTickets = 1;
  int totalAmount = 0;
  int extraCharges = 0;
  int totalCharges = 0;


  @override
  void initState() {
    super.initState();
    setState(() {
      noOfTicketsController.text = noOfTickets.toString();
      int amt = widget.ticketChoicePrice * noOfTickets;
      totalAmount = amt;
      extraCharges = (amt * (2 / 100)).toInt();
      totalCharges = totalAmount + extraCharges;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              width: 20,
              height: 25,
              child: Image.asset(
                'assets/images/back_arrow.png',
              )),
        ),
      ),
      body: SafeArea( 
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 340,
                                height: 400,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20))),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: Text(
                                                widget.trip.tripNumber,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffE4181D),
                                                  borderRadius: BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(20),
                                                      topLeft:
                                                          Radius.circular(20))),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(dateToTime(
                                                      widget.trip.departureTime)),
                                                  Text(dateToTime(
                                                      widget.trip.arrivalTime)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 50, vertical: 2),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Color(0xffED696C),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50),
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 2)),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 3,
                                                      // width: 10,
                                                      color: Color(0xffED696C),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Color(0xffED696C),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50),
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 2)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: Text(widget.trip
                                                        .departureLocationName),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 3,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(4.0),
                                                    child: Text(widget.trip
                                                        .arrivalLocationName),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 1),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      const Text("Company"),
                                                      widget.trip.companyName !=
                                                              ""
                                                          ? Text(
                                                              widget.trip
                                                                  .companyName,
                                                            )
                                                          : FutureBuilder(
                                                              future: widget.trip
                                                                  .setCompanyData(
                                                                      context),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return Text(
                                                                    widget.trip
                                                                            .companyData![
                                                                        'name'],
                                                                  );
                                                                } else {
                                                                  return Text(
                                                                      "Bus Stop");
                                                                }
                                                              }),
                                                    ],
                                                  ),
                                                  Text(
                                                    widget.trip.busPlateNo
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue[900]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Date Of Travel"),
                                                  Text(
                                                      dateToStringNew(
                                                        widget.trip.departureTime,
                                                      ),
                                                      style: TextStyle(
                                                          color: Colors.blue)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 2),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20),
                                                    child: Text("Total Seats"),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 3,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(4.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 80,
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        widget.trip.totalSeats
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffED696C),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 2),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20),
                                                    child:
                                                        Text("Remaining Seats"),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 3,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(4.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 80,
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        (widget.trip.totalSeats -
                                                                widget.trip
                                                                    .occupiedSeats)
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffED696C),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20),
                                                    child: Text("Amount Charged"),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 3,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 30,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      totalAmount.toString() +
                                                          " SHS",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.blue[900]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20),
                                                    child: Text("Extra Charges"),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 3,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    height: 30,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      extraCharges.toString() +
                                                          " SHS",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                          Colors.blue[900]),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(50))),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(50))),
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              width: 340,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  DottedLine(),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          child: QrImage(
                                            data: "Not Paid",
                                            version: QrVersions.auto,
                                            size: 100.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: const BorderRadius.only(
                                              bottomRight: Radius.circular(50))),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(50))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 340,
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Enter Number Of Tickets",
                                        style: TextStyle(color: Colors.blue[800]),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 40.0,
                                                // Set the desired height here
                                                child: TextField(
                                                  minLines: 1,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                  controller:
                                                      noOfTicketsController,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  onChanged: (val) {
                                                    if (val.trim().isNotEmpty) {
                                                      int n =
                                                          int.parse(val.trim());
                                                      setState(() {
                                                        noOfTickets = n;
                                                        int amt = widget
                                                                .ticketChoicePrice *
                                                            n;
                                                        // totalAmount = amt;
                                                        totalAmount = amt +
                                                            (amt * (2 / 100))
                                                                .toInt();
                                                      });
                                                    } else {
                                                      setState(() {
                                                        noOfTickets = 1;
                                                        int amt = widget
                                                                .ticketChoicePrice *
                                                            1;
                                                        totalAmount = amt +
                                                            (amt * (2 / 100))
                                                                .toInt();
                                                      });
                                                    }
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textAlign: TextAlign.center,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.red))),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final remainingSeats =
                    widget.trip.totalSeats - widget.trip.occupiedSeats;
                if (noOfTickets > remainingSeats) {
                  Get.snackbar("Error", 'Invalid number of tickets',
                      backgroundColor: Colors.grey[200]);
                  return;
                }
                Get.to(() => TicketPayment(
                      client: widget.client,
                      trip: widget.trip,
                      ticketChoice: widget.ticketChoice,
                      ticketPrice: widget.ticketChoicePrice,
                      noOfTickets: noOfTickets,
                      totalAmount: totalAmount,
                    ));
              },
              child: Container(
                // width: 300,
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: const Text(
                  "Buy Tickets",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                decoration: const BoxDecoration(
                    color: Color(0xffE4181D),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
