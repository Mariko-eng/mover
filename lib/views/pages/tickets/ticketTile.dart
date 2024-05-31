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

  @override
  void initState() {
    super.initState();
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
          height: 220,
          decoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.tripTicket.ticketType,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              widget.tripTicket.ticketNumber,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                fontSize: 17,
                                color: Colors.yellow[100],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.red[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tripTicket.status.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            dateToStringNew(
                                widget.tripTicket.trip!.departureTime),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Colors.blue[900],
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "SHS ${widget.tripTicket.total}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tripTicket.trip!.departureLocationName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white70,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.tripTicket.trip!.arrivalLocationName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.cyan,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tripTicket.buyerNames,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white70,
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.tripTicket.buyerPhoneNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.tripTicket.trip!.tripNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 14,
                              color: Colors.yellow,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.tripTicket.trip!.busPlateNo,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.tripTicket.createdAt.toDate().toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                              fontSize: 14,
                              color: Colors.blue[900],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  color: widget.tripTicket.status == "used"
                      ? Colors.indigo
                      : widget.tripTicket.status == "cancelled"
                      ? Colors.black
                      : Colors.red[900],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.tripTicket.status == "pending"
                        ? const Icon(
                      Icons.chair,
                      color: Colors.white70,
                      size: 30,
                    )
                        : widget.tripTicket.status == "cancelled"
                        ? const Icon(
                      Icons.cancel,
                      color: Colors.white70,
                      size: 30,
                    )
                        : const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white70,
                      size: 30,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.tripTicket.seatNumber,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 17, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     height: 200,
      //     decoration: BoxDecoration(
      //         color: Colors.red[400],
      //         borderRadius: BorderRadius.circular(10)
      //     ),
      //     child: Row(
      //       children: [
      //         Expanded(
      //           child: Padding(
      //             padding: const EdgeInsets.only(left: 20,top: 10),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text(widget.tripTicket.ticketType,
      //                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                           fontSize: 17,
      //                           color: Colors.white,
      //                           fontWeight: FontWeight.bold
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.only(right: 10),
      //                       child: Text(widget.tripTicket.ticketNumber,
      //                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                             fontSize: 17,
      //                             color: Colors.yellow[100],
      //                             fontWeight: FontWeight.bold
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(height: 10,),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Container(
      //                       height: 20,
      //                       width: 20,
      //                       decoration: BoxDecoration(
      //                           color: Colors.red[900],
      //                           borderRadius: BorderRadius.circular(10)
      //                       ),
      //                     ),
      //                     SizedBox(width: 10,),
      //                     Text(widget.tripTicket.status.toUpperCase(),
      //                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                           fontSize: 15,
      //                           color: Colors.white
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //                 SizedBox(height: 5,),
      //                 Row(
      //                   children: [
      //                     Container(
      //                       height: 20,
      //                       width: 20,
      //                       child: Icon(Icons.calendar_today,color: Colors.yellow,
      //                         size: 20,
      //                       ),
      //                     ),
      //                     SizedBox(width: 10,),
      //                     Text(dateToStringNew(widget.tripTicket.trip!.departureTime),
      //                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                           fontSize: 15,
      //                           color: Colors.white,
      //                         ))
      //                   ],
      //                 ),
      //                 SizedBox(height: 5,),
      //                 Row(
      //                   children: [
      //                     Container(
      //                       height: 20,
      //                       width: 20,
      //                       child: Icon(Icons.monetization_on,color: Colors.blue[900],
      //                         size: 20,
      //                       ),
      //                     ),
      //                     SizedBox(width: 10,),
      //                     Text("SHS " + widget.tripTicket.total.toString(),
      //                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                           fontSize: 15,
      //                           color: Colors.white,
      //                         )),
      //                   ],
      //                 ),
      //                 SizedBox(height: 5,),
      //                 Row(
      //                   children: [
      //                     Container(
      //                       height: 20,
      //                       width: 20,
      //                       child: Icon(Icons.location_on,color: Colors.green,
      //                         size: 20,
      //                       ),
      //                     ),
      //                     SizedBox(width: 10,),
      //                     Text(widget.tripTicket.trip!.departureLocationName,
      //                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                           fontSize: 15,
      //                           color: Colors.white,
      //                         )),
      //                     const SizedBox(width: 5,),
      //                     const SizedBox(
      //                       height: 20,
      //                       width: 20,
      //                       child: Icon(Icons.arrow_right_alt,color: Colors.white70,
      //                         size: 20,
      //                       ),
      //                     ),
      //                     SizedBox(width: 5,),
      //                     Text(widget.tripTicket.trip!.arrivalLocationName,
      //                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                           fontSize: 15,
      //                           color: Colors.white,
      //                         ))
      //                   ],
      //                 ),
      //                 SizedBox(height: 5,),
      //                 Row(
      //                   children: [
      //                     Container(
      //                       height: 20,
      //                       width: 20,
      //                       child: Icon(Icons.house_outlined,color: Colors.cyan,
      //                         size: 20,
      //                       ),
      //                     ),
      //                     SizedBox(width: 10,),
      //                     Text(companyName,
      //                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                           fontSize: 15,
      //                           color: Colors.white,
      //                         )),
      //                   ],
      //                 ),
      //                 SizedBox(height: 10,),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Text(widget.tripTicket.trip!.tripNumber,
      //                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                           fontSize: 12,
      //                           color: Colors.yellow,
      //                         )),
      //                     SizedBox(width: 10,),
      //                     Text(widget.tripTicket.trip!.busPlateNo,
      //                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                           fontSize: 12,
      //                           color: Colors.white70,
      //                         )),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         Container(
      //           width: 100,
      //           decoration: BoxDecoration(
      //               color: Colors.red[900],
      //               borderRadius: BorderRadius.only(
      //                   topRight: Radius.circular(10),
      //                   bottomRight: Radius.circular(10)
      //               )
      //           ),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               widget.tripTicket.status == "pending" ?
      //               Icon(Icons.chair,
      //                 color: Colors.white70,size: 30,) :
      //               Icon(Icons.check_circle_outline,color: Colors.white70,size: 30,),
      //               SizedBox(height: 5,),
      //               Text(widget.tripTicket.numberOfTickets.toString(),
      //                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //                     fontSize: 17,
      //                     color: Colors.white
      //                 ),
      //               ),
      //             ],
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
