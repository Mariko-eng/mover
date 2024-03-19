import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/travel/homeTravel.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/utils.dart';

class SuccessScreen extends StatefulWidget {
  final Client client;
  final Trip trip;
  final String ticketChoice;
  final int noOfTickets;
  final int amount;
  final String transactionID;
  final String txRef;

  const SuccessScreen({Key? key,
    required this.client,
    required this.trip,
    required this.ticketChoice,
    required this.noOfTickets,
    required this.amount,
    required this.transactionID,
    required this.txRef
  }) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Color(0xffE4181D),
        title: Text("Ticket Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check,size: 50,color: Colors.blue[700],)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Ticket Purchased Successfully!",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.green[900],
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                  width: 280,
                  height: 200,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text("Transaction ID",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 3,
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: Text(widget.transactionID.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blue[900])
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
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text("TaxRef",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   child: Container(
                                    //     height: 3,
                                    //   ),
                                    // ),
                                    Container(
                                      width: 80,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(widget.txRef.toString(),
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blue[900])
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
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text("Ticket Type",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 3,
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: Text(widget.ticketChoice.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blue[900])
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
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text("Number Of Tickets",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 3,
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: Text(widget.noOfTickets.toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blue[900])
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
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Text("Amount Paid",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
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
                                        widget.amount.toString() + " SHS",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue[900]),
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
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    DottedLine(),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(height: 40,),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Text("Trip Details",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 1),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.receipt,color: Colors.blue[900],size: 25,),
                                    SizedBox(width: 5,),
                                    Text("Trip Number",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(widget.trip.tripNumber)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 1),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.bus_alert,color: Colors.blue[900],size: 25,),
                                    SizedBox(width: 5,),
                                    Text("Bus Company",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(widget.trip.companyData!['name'])
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today,color: Colors.blue[900],size: 25,),
                                    SizedBox(width: 5,),
                                    const Text("Trip Date",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(dateToStringNew(
                                    widget.trip.departureTime))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(dateToTime(widget.trip.departureTime)),
                                Text(dateToTime(widget.trip.arrivalTime)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 2),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xffED696C),
                                      borderRadius:
                                      BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
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
                                      BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child:
                                  Text(widget.trip.departureLocationName),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 3,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(widget.trip.arrivalLocationName),
                                ),
                              ],
                            ),
                          ),
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
              const SizedBox(
                height: 20,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) =>
              //                 TripTickets(
              //                   client: widget
              //                       .client,
              //                 )));
              //     // Get.offAll(() => HomeTravel(
              //     //   client: widget.client,
              //     // ));
              //   },
              //   child: Container(
              //     width: 300,
              //     height: 50,
              //     alignment: Alignment.center,
              //     child: const Text(
              //       "VIEW TICKETS",
              //       style: TextStyle(color: Colors.white, fontSize: 15),
              //     ),
              //     decoration: const BoxDecoration(
              //         color: Colors.black45,
              //         borderRadius: BorderRadius.all(Radius.circular(20))),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              GestureDetector(
                onTap: () {
                  Get.offAll(() => HomeTravel(
                    client: widget.client,
                  ));
                },
                child: Container(
                  width: 300,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "DONE",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  decoration: const BoxDecoration(
                      color: Color(0xffE4181D),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         SizedBox(height: 20,),
      //         Column(
      //           children: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Icon(Icons.check_box,size: 50,color: Colors.blue[700],)
      //               ],
      //             ),
      //             SizedBox(height: 10,),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text("Ticket Purchased Successfully",
      //                   style: Theme.of(context).textTheme.headline5.copyWith(
      //                       color: Colors.blue[900],
      //                       fontWeight: FontWeight.w500),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //         SizedBox(height: 20,),
      //         Container(
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(10),
      //               border: Border.all(color: Color(0xffE4181D)),
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.grey[400],
      //                   offset: const Offset(
      //                     2.0,
      //                     2.0,
      //                   ),
      //                   blurRadius: 5.0,
      //                   spreadRadius: 5.0,
      //                 ),
      //               ]
      //           ),
      //           child: Column(
      //             children: [
      //               SizedBox(height: 30,),
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text("Transaction Id"),
      //                     Text(widget.transactionID),
      //                   ],
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text("TaxRef"),
      //                     Text(widget.txRef),
      //                   ],
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Row(
      //                   children: [
      //                     Text("Tickets",
      //                       style: Theme.of(context).textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 20),
      //                 child: Container(
      //                   padding: const EdgeInsets.symmetric(horizontal: 10),
      //                   height: 70,
      //                   decoration: BoxDecoration(
      //                       color: Colors.white,
      //                       borderRadius: BorderRadius.circular(10),
      //                       border: Border.all(color: Color(0xffE4181D)),
      //                       boxShadow: [
      //                         BoxShadow(
      //                           color: Colors.grey[400],
      //                           offset: const Offset(
      //                             2.0,
      //                             2.0,
      //                           ),
      //                           blurRadius: 5.0,
      //                           spreadRadius: 5.0,
      //                         ),
      //                       ]
      //                   ),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         children: [
      //                           Icon(Icons.receipt,color: Color(0xff8c2636),),
      //                           Text(widget.ticketChoice.toUpperCase()),
      //                         ],
      //                       ),
      //                       Text(widget.noOfTickets.toString(),
      //                         style: Theme.of(context).textTheme.headline5.copyWith(
      //                             color: Colors.blue[900],
      //                             fontWeight: FontWeight.bold),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(height: 20,),
      //               Container(
      //                 padding: const EdgeInsets.symmetric(horizontal: 10),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text("Trip Details",
      //                       style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
      //                     ),
      //                     SizedBox(height: 10,),
      //                     Row(
      //                       children: [
      //                         Icon(Icons.location_on,color: Color(0xffE4181D),),
      //                         Flexible(
      //                           child: Text(widget.trip.arrival['name'],
      //                             overflow: TextOverflow.ellipsis,
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                     SizedBox(height: 10,),
      //                     Row(
      //                       children: [
      //                         Icon(Icons.location_history,color: Color(0xffE4181D),),
      //                         Flexible(
      //                           child: Text(widget.trip.departure['name'],
      //                             overflow: TextOverflow.ellipsis,
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                     SizedBox(height: 10,),
      //
      //                     SizedBox(height: 30,),
      //                   ],
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         SizedBox(height: 30,),
      //         GestureDetector(
      //           onTap: (){
      //             Get.offAll(() => HomeTravel(
      //               client: widget.client,
      //             ));
      //           },
      //           child: Container(
      //             height: 40,
      //             width: double.infinity,
      //             alignment: Alignment.center,
      //             decoration: BoxDecoration(
      //                 color: Color(0xffE4181D),
      //                 borderRadius: BorderRadius.circular(10)
      //             ),
      //             child: Text("Done",
      //               style: TextStyle(color: Colors.white),
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
