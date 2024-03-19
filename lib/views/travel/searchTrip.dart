import 'package:bus_stop/contollers/authController.dart';
import 'package:bus_stop/models/destination.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/views/travel/Trips.dart';
import 'package:bus_stop/views/busCompany/busCompanyScreen.dart';
import 'package:bus_stop/views/v2/pages/help/helpScreen.dart';
import 'package:bus_stop/views/travel/tickets.dart';
import 'package:bus_stop/services/firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/user.dart';

class SearchTrip extends StatefulWidget {
  final Client client;

  const SearchTrip({Key? key, required this.client}) : super(key: key);

  @override
  _SearchTripState createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
  Firestore fireStore = Firestore();
  List<Trip>? trips;
  String dateInputText = "";

  getTrips({required String departureLocationId, required String arrivalLocationId}) async {
    final results =
        await fireStore.searchTrips(departureLocationId, arrivalLocationId);
    setState(() {
      trips = results;
    });
  }

  // final AuthService _auth = AuthService();
  bool show = true;
  final _arrivalController = TextEditingController();
  final _arrivalIdController = TextEditingController();
  final _departureController = TextEditingController();
  final _departureIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final destinations = Provider.of<List<Destination>>(context) ?? [];

    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffdfdfd),
        elevation: 0,
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
        title: Text(
          "TRAVEL MENU".toUpperCase(),
          style: TextStyle(color: Colors.red[900]),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => HelpScreen(
                    client: widget.client,
                  ));
            },
            child: Row(
              children: [
                Icon(Icons.help, color: Colors.red[900]),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/map.png',
                  repeat: ImageRepeat.repeat,
                ),
              ),
              Positioned(
                  top: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                show
                                    ? Container()
                                    : GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BusCompanyScreen(
                                                        client: widget.client,
                                                      )));
                                        },
                                        child: SizedBox(
                                          width: 200,
                                          height: 50,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                child: const Icon(
                                                  Icons.directions_bus,
                                                  color: Color(0xffffffff),
                                                ),
                                                decoration: BoxDecoration(
                                                    // color: Color(0xffE4181D),
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: 40,
                                                width: 100,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "Stops",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.red[900],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                show
                                    ? Container()
                                    : const SizedBox(
                                        height: 10,
                                      ),
                                show
                                    ? Container()
                                    : GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TripTickets(
                                                        client: widget.client,
                                                      )));
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 50,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                child: const Icon(
                                                  Icons.confirmation_num,
                                                  color: Color(0xffffffff),
                                                ),
                                                decoration: BoxDecoration(
                                                    // color: Color(0xffE4181D),
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TripTickets(
                                                                client: widget
                                                                    .client,
                                                              )));
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 100,
                                                  alignment: Alignment.center,
                                                  child: const Text(
                                                    "Tickets",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[900],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                show
                                    ? Container()
                                    : const SizedBox(
                                        height: 10,
                                      ),
                                show
                                    ? Container()
                                    : Container(
                                        width: 200,
                                        height: 50,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                await userProvider.signOut();

                                                // await _auth.signOut();
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                child: const Icon(
                                                  Icons.logout,
                                                  color: Color(0xffffffff),
                                                ),
                                                decoration: BoxDecoration(
                                                    // color: Color(0xffE4181D),
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                await userProvider.signOut();
                                                // await _auth.signOut();
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 100,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "Logout",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.red[900],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                !show
                                    ? Container()
                                    : const SizedBox(
                                        height: 10,
                                      ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      show = !show;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: !show
                                        ? Stack(
                                            children: [
                                              Container(
                                                child: Image.asset(
                                                    'assets/images/stop.png'),
                                              ),
                                              const Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Icon(
                                                      Icons.cancel_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ))
                                            ],
                                          )
                                        : Stack(
                                            children: [
                                              Image.asset(
                                                  'assets/images/image1.png'),
                                              const Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Icon(
                                                      Icons.menu,
                                                      color: Colors.white,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 50),
                                              child: Text(
                                                "Where would you like",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 50),
                                              child: Text(
                                                "to go today?",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 10),
                                            child: Container(
                                              // height: 200,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffF4F7FA),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 30,
                                                            bottom: 25,
                                                            left: 10),
                                                    width: 50,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                            ),
                                                            const Expanded(
                                                              child: DottedLine(
                                                                // lineLength: double.minPositive,
                                                                dashColor:
                                                                    Colors.red,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const Expanded(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: DottedLine(
                                                              direction:
                                                                  Axis.vertical,
                                                              dashColor:
                                                                  Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .red,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                child:
                                                                    const DottedLine(
                                                                  dashColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 10),
                                                    width: 240,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          width: 220,
                                                          height: 60,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                // top: 0,
                                                                // left: 40,
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width: 220,
                                                                  height: 50,
                                                                  child:
                                                                      TextField(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    readOnly:
                                                                        true,
                                                                    decoration: InputDecoration(
                                                                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                                                        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                                                        label: Container(
                                                                          width:
                                                                              220,
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              const Icon(
                                                                                Icons.location_on_outlined,
                                                                                size: 30,
                                                                                color: Colors.red,
                                                                              ),
                                                                              const Text("From"),
                                                                              Expanded(child: Container()),
                                                                            ],
                                                                          ),
                                                                        )),
                                                                    onTap: () {
                                                                      showDestinations(
                                                                          context,
                                                                          destinations,
                                                                          true);
                                                                    },
                                                                    controller:
                                                                        _departureController,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                0xffffffff),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            child: Container(),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                              width: 220,
                                                              height: 60,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Stack(
                                                                children: [
                                                                  Positioned(
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      width:
                                                                          220,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          TextField(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        readOnly:
                                                                            true,
                                                                        decoration: InputDecoration(
                                                                            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                                                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                                                            label: Container(
                                                                              width: 220,
                                                                              child: Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  const Icon(
                                                                                    Icons.location_on_outlined,
                                                                                    size: 30,
                                                                                    color: Colors.red,
                                                                                  ),
                                                                                  const Text("To"),
                                                                                  Expanded(child: Container()),
                                                                                ],
                                                                              ),
                                                                            )),
                                                                        onTap:
                                                                            () {
                                                                          showDestinations(
                                                                              context,
                                                                              destinations,
                                                                              false);
                                                                        },
                                                                        controller:
                                                                            _arrivalController,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                      0xffffffff),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      if (_departureIdController !=
                                                              null &&
                                                          _arrivalIdController !=
                                                              null) {
                                                        await getTrips(
                                                          departureLocationId:
                                                              _departureIdController
                                                                  .text,
                                                          arrivalLocationId:
                                                              _arrivalIdController
                                                                  .text,
                                                        );
                                                      }
                                                      if (trips != null) {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Trips(
                                                                          client:
                                                                              widget.client,
                                                                          trips:
                                                                              trips!,
                                                                        )));
                                                      }
                                                    },
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0xffE4181D),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                        child: const Text(
                                                          "Search Trip",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDestinations(
      BuildContext context, List<Destination> data, bool isDeparture) async {
    List sr = [];
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _ctr = TextEditingController();
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: LayoutBuilder(
                        builder: (ctx, constraints) {
                          return Column(
                            children: [
                              Container(
                                height: 50,
                                width: constraints.maxWidth,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Search Here",
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red))),
                                      controller: _ctr,
                                      onChanged: (val) {
                                        List l = [];
                                        setState(() {
                                          if (_ctr.text.isNotEmpty) {
                                            for (int i = 0;
                                                i < data.length;
                                                i++) {
                                              if (data[i]
                                                  .name
                                                  .toLowerCase()
                                                  .contains(_ctr.text
                                                      .toLowerCase())) {
                                                l.add(data[i]);
                                              }
                                            }
                                            sr = l;
                                          } else {
                                            sr = l;
                                          }
                                        });
                                      },
                                    )),
                                    const Icon(Icons.search)
                                  ],
                                ),
                              ),
                              Container(
                                  height: constraints.maxHeight * 0.8,
                                  width: constraints.maxWidth,
                                  color: Colors.grey[200],
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: sr.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: sr.length,
                                          itemBuilder: (context1, int i) =>
                                              GestureDetector(
                                                onTap: () {
                                                  if (isDeparture) {
                                                    setState(() {
                                                      _departureController
                                                          .text = sr[i].name;
                                                      _departureIdController
                                                          .text = sr[i].id;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _arrivalController.text =
                                                          sr[i].name;
                                                      _arrivalIdController
                                                          .text = sr[i].id;
                                                    });
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.arrow_right),
                                                    Text(sr[i].name),
                                                  ],
                                                ),
                                              ))
                                      : ListView.builder(
                                          itemCount: data.length,
                                          itemBuilder: (context1, int i) =>
                                              GestureDetector(
                                                onTap: () {
                                                  if (isDeparture) {
                                                    setState(() {
                                                      _departureController
                                                          .text = data[i].name;
                                                      _departureIdController
                                                          .text = data[i].id;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _arrivalController.text =
                                                          data[i].name;
                                                      _arrivalIdController
                                                          .text = data[i].id;
                                                    });
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.arrow_right),
                                                    Text(data[i].name),
                                                  ],
                                                ),
                                              ))),
                            ],
                          );
                        },
                      ),
                    ),
                  ));
        });
  }
}
