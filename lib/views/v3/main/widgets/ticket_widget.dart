import 'package:flutter/material.dart';
import 'package:bus_stop/config/shared/utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';

class TicketWidget extends StatefulWidget {
  final TripTicket ticket;

  const TicketWidget({super.key, required this.ticket});

  @override
  State<TicketWidget> createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {

    return buildTicketWidget(context, widget.ticket);


    // return FutureBuilder(
    //   future: widget.ticket.setTripData(context),
    //   // ignore: missing_return
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.waiting:
    //         return Container();
    //         // return const LoadingWidget();
    //       case ConnectionState.none:
    //         return Container();
    //         // return const LoadingWidget();
    //         return Container();
    //       case ConnectionState.active:
    //         return Container();
    //         // return const LoadingWidget();
    //       case ConnectionState.done:
    //         return buildTicketWidget(context, widget.ticket);
    //     }
    //   },
    // );
  }
}

Widget buildTicketWidget(BuildContext context, TripTicket ticket) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.companyName.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ticket.departureLocation,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dateToTime(ticket.trip!.departureTime),
                            // "08:00 AM",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 100,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 2,
                                color: Colors.red.shade100,
                              ),
                            ),
                            Icon(
                              Icons.bus_alert_outlined,
                              color: Colors.blueGrey,
                            ),
                            Expanded(
                              child: Container(
                                height: 2,
                                color: Colors.red.shade100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ticket.arrivalLocation,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dateToTime(ticket.trip!.arrivalTime),
                            // "08:00 AM",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Passenger",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ticket.buyerNames,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Ticket NO",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ticket.ticketNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bus Plate",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ticket.trip!.busPlateNo.isEmpty
                                ? "----"
                                : ticket.trip!.busPlateNo,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Date",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dateToStringNew(ticket.trip!.departureTime),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          color: Color(0xffffffff),
          child: Row(
            children: [
              SizedBox(
                height: 40,
                width: 20,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          offset: Offset(1, 0)),
                      BoxShadow(color: Colors.white, offset: Offset(-15, 0)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate the number of items based on the width of the parent widget.
                    final itemCount = (constraints.maxWidth / 10).floor();

                    return Flex(
                      children: List.generate(
                        itemCount,
                        (index) => SizedBox(
                          height: 1,
                          width: 5,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.black54),
                          ),
                        ),
                      ),
                      direction: Axis.horizontal,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 40,
                width: 20,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    // border: Border(
                    //   right: BorderSide(color: Colors.white)
                    // ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          // blurRadius: 1,
                          offset: Offset(-1, 0)),
                      BoxShadow(color: Colors.white, offset: Offset(15, 0)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(4, 15), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(
                  "Scan this code to get on the bus",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 140,
                  width: 140,
                  child: QrImage(
                    data: ticket.ticketNumber,
                    version: QrVersions.auto,
                    size: 100.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
