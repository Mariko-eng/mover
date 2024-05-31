import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/config/shared/utils.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketDetailsView extends StatefulWidget {
  final String ticketId;

  const TicketDetailsView({Key? key, required this.ticketId}) : super(key: key);

  @override
  _TicketDetailsViewState createState() => _TicketDetailsViewState();
}

class _TicketDetailsViewState extends State<TicketDetailsView> {
  GlobalKey _globalKey = new GlobalKey();
  bool isDownloading = false;

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
        title: Text(
          "My Ticket",
          style: TextStyle(color: Colors.red[900]),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  Icons.print,
                  color: Colors.red[900],
                  size: 30,
                ),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: fetchTicketDetail(ticketId: widget.ticketId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Expanded(
                      child: Center(
                    child: Text("Something Went Wrong!"),
                  ));
                }
                if (!snapshot.hasData) {
                  return Expanded(
                      child: Center(
                    child: LoadingWidget(),
                  ));
                } else {
                  TripTicket? ticket = snapshot.data;
                  if (ticket == null) {
                    return Expanded(
                        child: Center(
                      child: Text("Sorry Ticket Not Found!"),
                    ));
                  }
                  return FutureBuilder(
                      future: ticket.setTripData(context),
                      builder: (context, snapshot2) {
                        if (snapshot2.hasError) {}
                        if (!snapshot.hasData) {
                          return Expanded(
                              child: Center(
                            child: LoadingWidget(),
                          ));
                        } else {
                          TripTicket? tripTicket = snapshot.data;
                          if (tripTicket == null) {
                            return Expanded(
                                child: Center(
                              child: Text("Sorry Ticket Not Found!"),
                            ));
                          } else {
                            if (tripTicket.trip == null) {
                              return Container();
                            }
                            return SingleChildScrollView(
                              child: RepaintBoundary(
                                key: _globalKey,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 350,
                                          height: 420,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(20),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20))),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          tripTicket
                                                              .ticketNumber
                                                              .toUpperCase(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: tripTicket.status == "used"
                                                                ? Colors.indigo
                                                                : tripTicket.status == "cancelled"
                                                                ? Colors.black
                                                                : Colors.red[900],
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20))),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 40,
                                                                vertical: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(dateToTime(
                                                                tripTicket.trip!
                                                                    .departureTime)),
                                                            Text(dateToTime(
                                                                tripTicket.trip!
                                                                    .arrivalTime)),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 50,
                                                                vertical: 2),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xffED696C),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white,
                                                                      width:
                                                                          2)),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                height: 3,
                                                                // width: 10,
                                                                color: const Color(
                                                                    0xffED696C),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                      0xffED696C),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white,
                                                                      width:
                                                                          2)),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 30,
                                                                vertical: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          20),
                                                              child: Text(tripTicket
                                                                  .departureLocation),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                height: 3,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Text(tripTicket
                                                                  .arrivalLocation),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 1),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("Date"),
                                                              Text(dateToStringNew(
                                                                  tripTicket
                                                                      .trip!
                                                                      .departureTime)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 2),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                      "Company"),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(tripTicket
                                                                      .companyName),
                                                                  Text(tripTicket
                                                                      .trip!
                                                                      .busPlateNo
                                                                      .toUpperCase()),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 2),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            20),
                                                                child: Text(
                                                                    "Seat No"),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 3,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Text(
                                                                  tripTicket.seatNumber ==
                                                                          ""
                                                                      ? "??"
                                                                      : tripTicket
                                                                          .seatNumber
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .red[
                                                                          900]),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 2),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            20),
                                                                child: Text(
                                                                    "Ticket Price"),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Text(
                                                                  tripTicket
                                                                      .trip!
                                                                      .price
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .red[
                                                                          900]),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 2),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            20),
                                                                child: Text(
                                                                    "Total"),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Text(
                                                                  tripTicket
                                                                      .total
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .red[
                                                                          900]),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 2),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            20),
                                                                child: Text(
                                                                    "Buyer Name/s"),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Text(
                                                                  tripTicket
                                                                      .buyerNames
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .red[
                                                                          900]),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      30,
                                                                  vertical: 2),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            20),
                                                                child: Text(
                                                                    "Buyer Contact"),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        4.0),
                                                                child: Text(
                                                                  tripTicket
                                                                      .buyerPhoneNumber
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .red[
                                                                          900]),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      50))),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      50))),
                                                ),
                                              )
                                            ],
                                          )),
                                      Container(
                                        width: 350,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Stack(
                                          children: [
                                            DottedLine(),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    50))),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    50))),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: 150,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      height: 100,
                                                      child: QrImage(
                                                        data: "Ticket Number: " +
                                                            tripTicket
                                                                .ticketNumber +
                                                            ", " +
                                                            "Bus Company: " +
                                                            tripTicket
                                                                .companyName +
                                                            ", " +
                                                            "Trip Price: " +
                                                            tripTicket
                                                                .trip!.price
                                                                .toString() +
                                                            ", " +
                                                            "Tickets: " +
                                                            tripTicket
                                                                .numberOfTickets
                                                                .toString() +
                                                            ", " +
                                                            "Amount Paid: " +
                                                            tripTicket
                                                                .amountPaid
                                                                .toString() +
                                                            ", Date Of Payment: " +
                                                            tripTicket.createdAt
                                                                .toDate()
                                                                .toString(),
                                                        version:
                                                            QrVersions.auto,
                                                        size: 100.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                              ),
                            );
                          }
                        }
                      });
                }
              }),
        ],
      ),
    );
  }

//   Future<Uint8List> _capturePng() async {
//     try {
//       print('inside');
//       inside = true;
//       RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject();
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData byteData =
//       await image.toByteData(format: ui.ImageByteFormat.png);
//       Uint8List pngBytes = byteData.buffer.asUint8List();
// //create file
//       final String dir = (await getApplicationDocumentsDirectory()).path;
//       imagePath = '$dir/file_name${DateTime.now()}.png';
//       capturedFile = File(imagePath);
//       await capturedFile.writeAsBytes(pngBytes);
//       print(capturedFile.path);
//       final result = await ImageGallerySaver.saveImage(pngBytes,
//           quality: 60, name: "file_name${DateTime.now()}");
//       print(result);
//       print('png done');
//       return pngBytes;
//     } catch (e) {
//       print(e);
//     }
//   }
}
