import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/config/shared/utils.dart';
import 'package:bus_stop/views/pages/tickets/ticket_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/config/collections/index.dart';

class TicketTile extends StatefulWidget {
  final Client client;
  final TripTicket tripTicket;

  const TicketTile({Key? key, required this.client, required this.tripTicket})
      : super(key: key);

  @override
  _TicketTileState createState() => _TicketTileState();
}

class _TicketTileState extends State<TicketTile> {
  String companyName = "";

  _getCompanyInfo() async {
    try {
      String docId = widget.tripTicket.trip!.company.id;
      DocumentSnapshot snap =
          await AppCollections.companiesRef.doc(docId).get();

      Map data = snap.data() as Map;
      if (data == null) {
        if (mounted) {
          setState(() {
            companyName = "Bus Stop";
          });
        }
      } else if (mounted) {
        setState(() {
          companyName = data["name"] ?? "Bus Stop";
          // companyName = snap.get("name") ?? "Bus Stop";
        });
      }
    } catch (e) {
      print(e.toString());
      if (mounted) {
        setState(() {
          companyName = "Bus Stop";
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getCompanyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TicketDetailsView(
                  ticketId: widget.tripTicket.ticketId,
                      // client: widget.client,
                      // tripTicket: widget.tripTicket,
                      // companyName: companyName,
                      // tripPrice: widget.tripTicket.trip!.price.toString(),
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.tripTicket.ticketType,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(widget.tripTicket.ticketNumber,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 17,
                                  color: Colors.yellow[100],
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(widget.tripTicket.status.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            child: Icon(Icons.calendar_today,color: Colors.yellow,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(dateToStringNew(widget.tripTicket.trip!.departureTime),
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            child: Icon(Icons.monetization_on,color: Colors.blue[900],
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text("SHS " + widget.tripTicket.total.toString(),
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            child: Icon(Icons.location_on,color: Colors.green,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(widget.tripTicket.trip!.departureLocationName,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                color: Colors.white,
                              )),
                          const SizedBox(width: 5,),
                          const SizedBox(
                            height: 20,
                            width: 20,
                            child: Icon(Icons.arrow_right_alt,color: Colors.white70,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(widget.tripTicket.trip!.arrivalLocationName,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            child: Icon(Icons.house_outlined,color: Colors.cyan,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(companyName,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(widget.tripTicket.trip!.tripNumber,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 12,
                                color: Colors.yellow,
                              )),
                          SizedBox(width: 10,),
                          Text(widget.tripTicket.trip!.busPlateNo,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 12,
                                color: Colors.white70,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.red[900],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.tripTicket.status == "pending" ?
                    Icon(Icons.chair,
                      color: Colors.white70,size: 30,) :
                    Icon(Icons.check_circle_outline,color: Colors.white70,size: 30,),
                    SizedBox(height: 5,),
                    Text(widget.tripTicket.numberOfTickets.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 17,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      //   child: Container(
      //       width: 300,
      //       height: 325,
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           border: Border.all(
      //             color: Colors.red,
      //           )),
      //       child: Stack(
      //         children: [
      //           Stack(
      //             children: [
      //               Align(
      //                 alignment: Alignment.center,
      //                 child: Container(
      //                   decoration: const BoxDecoration(
      //                       color: Colors.white,
      //                       borderRadius: BorderRadius.only(
      //                         topRight: Radius.circular(20),
      //                         topLeft: Radius.circular(20),
      //                         bottomRight: Radius.circular(25),
      //                         bottomLeft: Radius.circular(25),
      //                       )),
      //                   child: Column(
      //                     children: [
      //                       Container(
      //                         height: 50,
      //                         alignment: Alignment.center,
      //                         padding: EdgeInsets.symmetric(horizontal: 18),
      //                         child: Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Text(
      //                               widget.tripTicket.ticketNumber
      //                                   .toUpperCase(),
      //                               // widget.tripTicket.trip.id,
      //                               style: const TextStyle(color: Colors.white),
      //                             ),
      //                           ],
      //                         ),
      //                         decoration: BoxDecoration(
      //                             color:
      //                                 widget.tripTicket.ticketType == "Ordinary"
      //                                     ? const Color(0xffE4181D)
      //                                     : const Color(0xffeede90),
      //                             borderRadius: const BorderRadius.only(
      //                                 topRight: Radius.circular(10),
      //                                 topLeft: Radius.circular(10))),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 40, vertical: 10),
      //                         child: Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Text(dateToTime(
      //                                 widget.tripTicket.trip!.departureTime)),
      //                             Text(dateToTime(
      //                                 widget.tripTicket.trip!.arrivalTime)),
      //                           ],
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 50, vertical: 2),
      //                         child: Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Container(
      //                               width: 20,
      //                               height: 20,
      //                               decoration: BoxDecoration(
      //                                   color: const Color(0xffED696C),
      //                                   borderRadius: BorderRadius.circular(50),
      //                                   border: Border.all(
      //                                       color: Colors.white, width: 2)),
      //                             ),
      //                             Expanded(
      //                               child: Container(
      //                                 height: 3,
      //                                 // width: 10,
      //                                 color: const Color(0xffED696C),
      //                               ),
      //                             ),
      //                             Container(
      //                               width: 20,
      //                               height: 20,
      //                               decoration: BoxDecoration(
      //                                   color: const Color(0xffED696C),
      //                                   borderRadius: BorderRadius.circular(50),
      //                                   border: Border.all(
      //                                       color: Colors.white, width: 2)),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 30, vertical: 10),
      //                         child: Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Padding(
      //                               padding: const EdgeInsets.only(right: 20),
      //                               child: Text(
      //                                   widget.tripTicket.departureLocation),
      //                             ),
      //                             Expanded(
      //                               child: Container(
      //                                 height: 3,
      //                               ),
      //                             ),
      //                             Padding(
      //                               padding: const EdgeInsets.all(4.0),
      //                               child:
      //                                   Text(widget.tripTicket.arrivalLocation),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       companyName == ""
      //                           ? Container()
      //                           : Padding(
      //                               padding: const EdgeInsets.symmetric(
      //                                   horizontal: 30, vertical: 1),
      //                               child: Row(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.spaceBetween,
      //                                 children: [
      //                                   Column(
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.start,
      //                                     children: [
      //                                       const Text("Company"),
      //                                       Text(companyName),
      //                                     ],
      //                                   ),
      //                                   Text(
      //                                       widget.tripTicket.trip!.busPlateNo.toUpperCase(),
      //                                     style: TextStyle(
      //                                         fontWeight:
      //                                         FontWeight.bold,
      //                                         color: Colors.blue[900]
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //                             ),
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 30, vertical: 2),
      //                         child: Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Column(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: [
      //                                 const Text("Date"),
      //                                 Text(dateToStringNew(widget
      //                                     .tripTicket.trip!.departureTime))
      //                               ],
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 30, vertical: 5),
      //                         child: Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Column(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: [
      //                                 const Text("Amount Paid"),
      //                                 Text(widget.tripTicket.total.toString() +
      //                                     " SHS"),
      //                               ],
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 30, vertical: 1),
      //                         child: Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           crossAxisAlignment: CrossAxisAlignment.center,
      //                           children: [
      //                             const Text("Number Of Tickets"),
      //                             Container(
      //                                 width: 50,
      //                                 height: 40,
      //                                 alignment: Alignment.center,
      //                                 // color: Color(0xffED696C),
      //                                 child: Row(
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.center,
      //                                   children: [
      //                                     const Icon(
      //                                       Icons.person,
      //                                       color: Colors.grey,
      //                                       size: 15,
      //                                     ),
      //                                     Text(
      //                                       widget.tripTicket.numberOfTickets
      //                                           .toString(),
      //                                       style: const TextStyle(
      //                                           color: Color(0xffED696C),
      //                                           fontSize: 20),
      //                                     ),
      //                                   ],
      //                                 ))
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Positioned(
      //               bottom: 15,
      //               left: -10,
      //               child: Container(
      //                 width: 35,
      //                 height: 30,
      //                 alignment: Alignment.center,
      //                 decoration: BoxDecoration(
      //                     color: widget.tripTicket.status == "pending"
      //                         ? Colors.green
      //                         : Colors.black87,
      //                     borderRadius: BorderRadius.circular(40)),
      //                 child: Text(
      //                   widget.tripTicket.status == "pending" ? "Y" : "x",
      //                   style:
      //                       const TextStyle(color: Colors.white, fontSize: 10),
      //                 ),
      //               ))
      //         ],
      //       )),
      // ),
    );
  }
}
