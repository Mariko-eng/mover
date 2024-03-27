import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/services/cargo_service.dart';
import 'package:bus_stop/config/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/user.dart';

class CargoCheckoutView extends StatefulWidget {
  final String packageDesc;
  final int weight;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final Trip trip;
  final Client client;
  const CargoCheckoutView({super.key, required this.trip, required this.packageDesc, required this.weight, required this.senderName, required this.senderPhone, required this.receiverName, required this.receiverPhone, required this.client});

  @override
  State<CargoCheckoutView> createState() => _CargoCheckoutViewState();
}

class _CargoCheckoutViewState extends State<CargoCheckoutView> {
  @override
  Widget build(BuildContext context) {

    double charges = calculateCargoCharges(ticketPrice: widget.trip.price.toDouble(), weight: widget.weight.toDouble());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfffdfdfd),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SizedBox(
              width: 20,
              height: 25,
              child: Image.asset(
                'assets/images/back_arrow.png',
              )),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Checkout",
              style: TextStyle(fontSize: 20, color: Colors.red[900]),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.backpack_outlined,
              color: Colors.blue[900],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Package Description",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.packageDesc,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Package Weight In Kgs",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.weight.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Sender Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.senderName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.senderPhone,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: Colors.grey[600]),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Receiver Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.receiverName.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.receiverPhone,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Trip Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        Card(
                          child: ListTile(
                            title: Text(
                              dateToString(
                                  widget.trip.departureTime),
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 12),
                            ),
                            trailing: Text(
                                widget.trip.companyName),
                            subtitle: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.trip.departureLocationName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                      fontSize: 15,
                                      color: Colors
                                          .green[800],
                                      fontWeight:
                                      FontWeight
                                          .w400),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons
                                      .arrow_right_alt_rounded,
                                  color: Colors.blue[800],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.trip.arrivalLocationName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                      fontSize: 15,
                                      color:
                                      Colors.red[800],
                                      fontWeight:
                                      FontWeight
                                          .w400),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Estimated Charges",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                          fontSize: 20,
                          color:
                          Colors.black54,
                          fontWeight:
                          FontWeight
                              .bold),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("UGX",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                              fontSize: 15,
                              color:
                              Colors.red[800],
                              fontWeight:
                              FontWeight
                                  .w400),
                        ),
                        Text(charges.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                              fontSize: 20,
                              color:
                              Colors.red[800],
                              fontWeight:
                              FontWeight
                                  .w400),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.red[900],
                  borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: Text(
                "Place Order",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
