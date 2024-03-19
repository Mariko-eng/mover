import 'package:bus_stop/views/v2/pages/cargo/home_cargo_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/destination.dart';
import 'package:bus_stop/views/v2/pages/trips_search/trip_search_list_view.dart';
import 'package:bus_stop/views/v2/pages/trips_search/trip_search_new.dart';
import 'package:bus_stop/views/v2/widgets/bottom_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/contollers/authController.dart';
import 'package:bus_stop/views/v2/pages/help/helpScreen.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _fromCtr = TextEditingController();
  final _toCtr = TextEditingController();

  bool isFrom = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Destination? _fromDestination;
  Destination? _toDestination;

  late String currentDate;

  _setPlace(Destination destination) {
    setState(() {
      if (isFrom) {
        _fromDestination = destination;
        _fromCtr.text = destination.name;
      } else {
        _toDestination = destination;
        _toCtr.text = destination.name;
      }
    });
  }

  bool show = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentDate = DateTime.now().day.toString() +
          "/" +
          DateTime.now().month.toString() +
          "/" +
          DateTime.now().year.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      // drawer: DrawerView(),
      body: userProvider.client == null
          ? Container()
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 30, right: 20),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Hello, Welcome!",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red[900]),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Search For Your Trip!",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.red[900]),
                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              'assets/images/image11.png',
                              height: 200,
                              width: 300,
                            )),
                        Positioned(
                          top: 0,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // show
                              //     ? Container()
                              //     : GestureDetector(
                              //         onTap: () {
                              //           Get.to(() => HomeCargoView(
                              //               client: userProvider.client!));
                              //         },
                              //         child: Container(
                              //           width: 200,
                              //           height: 50,
                              //           child: Row(
                              //             children: [
                              //               Container(
                              //                 width: 50,
                              //                 height: 50,
                              //                 child: const Icon(
                              //                   Icons.backpack_outlined,
                              //                   color: Color(0xffffffff),
                              //                 ),
                              //                 decoration: BoxDecoration(
                              //                     // color: Color(0xffE4181D),
                              //                     color: Colors.black,
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             50)),
                              //               ),
                              //               const SizedBox(
                              //                 width: 5,
                              //               ),
                              //               GestureDetector(
                              //                 onTap: () {
                              //                   Get.to(() => HomeCargoView(
                              //                       client:
                              //                           userProvider.client!));
                              //                 },
                              //                 child: Container(
                              //                   height: 40,
                              //                   width: 100,
                              //                   alignment: Alignment.center,
                              //                   child: const Text(
                              //                     "Cargo",
                              //                     style: TextStyle(
                              //                         color: Colors.white,
                              //                         fontSize: 18,
                              //                         fontWeight:
                              //                             FontWeight.bold),
                              //                   ),
                              //                   decoration: BoxDecoration(
                              //                       color: Colors.red[900],
                              //                       borderRadius:
                              //                           BorderRadius.circular(
                              //                               10)),
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              // show
                              //     ? Container()
                              //     : const SizedBox(
                              //         height: 5,
                              //       ),
                              show
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        Get.to(() => HelpScreen(
                                            client: userProvider.client!));
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
                                                Icons.help,
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
                                                Get.to(() => HelpScreen(
                                                    client:
                                                        userProvider.client!));
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 100,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "Help",
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
                                      height: 5,
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
                                              _logoutDialog(
                                                  userProvider: userProvider);
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
                                              _logoutDialog(
                                                  userProvider: userProvider);
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
                                      height: 5,
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
                                      borderRadius: BorderRadius.circular(50)),
                                  child: !show
                                      ? Stack(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                  'assets/images/stop.png'),
                                            ),
                                            const Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
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
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
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
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ]),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        width: 40,
                                        height: 40,
                                        child:
                                            const Icon(Icons.location_history)),
                                    Container(
                                      width: 5,
                                      height: 100,
                                      color: Color(0xffE4181D),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text("From"),
                                          Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 40,
                                        child: TextField(
                                          controller: _fromCtr,
                                          readOnly: true,
                                          onTap: () {
                                            setState(() {
                                              isFrom = true;
                                            });
                                            Get.to(() => TripSearchNewView(
                                                setPlace: _setPlace));
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Source",
                                              hintStyle:
                                                  TextStyle(fontSize: 14)),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        width: 40,
                                        height: 40,
                                        child: const Icon(Icons.location_on)),
                                    Container(
                                      width: 5,
                                      height: 100,
                                      color: Color(0xffE4181D),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text("To"),
                                          Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 40,
                                        child: TextField(
                                          controller: _toCtr,
                                          readOnly: true,
                                          onTap: () {
                                            setState(() {
                                              isFrom = false;
                                            });
                                            Get.to(() => TripSearchNewView(
                                                setPlace: _setPlace));
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Destination",
                                              hintStyle:
                                                  TextStyle(fontSize: 14)),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_fromDestination == null) {
                                Get.snackbar("Failed",
                                    "Please Select Your Departure Destination",
                                    backgroundColor: Colors.orange,
                                    colorText: Colors.white);
                                return;
                              }
                              if (_toDestination == null) {
                                Get.snackbar("Failed",
                                    "Please Select Your Arrival Destination",
                                    backgroundColor: Colors.orange,
                                    colorText: Colors.white);
                                return;
                              }
                              if (_fromDestination!.id == _toDestination!.id) {
                                Get.snackbar(
                                    "Failed", "Destinations Must Be Different!",
                                    backgroundColor: Colors.orange,
                                    colorText: Colors.white);
                                return;
                              } else {
                                Get.to(() => TripSearchListView(
                                    fro: _fromDestination!,
                                    to: _toDestination!));
                              }
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xffE4181D),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  "SEARCH TRIP".toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.white),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
      bottomNavigationBar: buildBottomAppBar(context: context, activeBar: 0),
    );
  }

  void _logoutDialog({required UserProvider userProvider}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          bool isLoading = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(builder: (context) {
                var height = 50.0;
                var width = MediaQuery.of(context).size.width * 0.8;

                return Container(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "Are You Sure You Want Logout?.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (isLoading) {
                            return;
                          }
                          Get.back();
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red[200],
                                border: Border.all(color: Colors.red[900]!),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "NO",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.red[900]),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pop();
                          userProvider.signOut();
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text("YES",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ))),
                      ),
                    )
                  ],
                )
              ],
            );
          });
        });
  }
}
