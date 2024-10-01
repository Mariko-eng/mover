// import 'package:bus_stop/views/pages/payment/TransactionTickets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:bus_stop/models/trip.dart';
// import 'package:bus_stop/models/user.dart';
// import 'package:bus_stop/views/main/home_view.dart';
// import 'package:bus_stop/views/pages/tickets/ticketsList.dart';
//
// class PurchaseTicketSuccess extends StatefulWidget {
//   final String transactionId;
//   final Client client;
//   final Trip trip;
//   final String ticketChoice;
//   final int noOfTickets;
//   final int amount;
//   final String buyerName;
//   final String buyerEmail;
//   final String buyerPhone;
//
//   const PurchaseTicketSuccess({
//     Key? key,
//     required this.transactionId,
//     required this.client,
//     required this.trip,
//     required this.ticketChoice,
//     required this.noOfTickets,
//     required this.amount,
//     required this.buyerName,
//     required this.buyerEmail,
//     required this.buyerPhone,
//   }) : super(key: key);
//
//   @override
//   _PurchaseTicketSuccessState createState() => _PurchaseTicketSuccessState();
// }
//
// class _PurchaseTicketSuccessState extends State<PurchaseTicketSuccess> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(
//       //   backgroundColor: Colors.white,
//       //   elevation: 0,
//       //   centerTitle: true,
//       //   // title: Text(
//       //   //   "Congratulations!",
//       //   //   style: TextStyle(
//       //   //       fontWeight: FontWeight.bold,
//       //   //       fontSize: 18,
//       //   //       color: Colors.green[900]),
//       //   // ),
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                           width: 80,
//                           height: 80,
//                           child: Image.asset('assets/images/image5.png')),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.check_box,
//                         size: 100,
//                         color: Colors.green[700],
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Hey, Congratulations!",
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 17,
//                             fontWeight: FontWeight.w400,
//                             color: Colors.green[800]),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         "Trip",
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black),
//                       ),
//                       Text(
//                         widget.trip.tripNumber,
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 17,
//                             fontWeight: FontWeight.w400,
//                             color: Theme.of(context).primaryColor),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             widget.trip.departureLocationName,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w400,
//                                     color: Theme.of(context).primaryColor),
//                           ),
//                           Icon(
//                             Icons.arrow_circle_right,
//                             color: Colors.blue[900],
//                           ),
//                           Text(
//                             widget.trip.arrivalLocationName,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w400,
//                                     color: Theme.of(context).primaryColor),
//                           )
//                         ],
//                       ),
//                       Text(
//                         "Company",
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         widget.trip.companyName,
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.red),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         "Ticket Type",
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black),
//                       ),
//                       Text(
//                         widget.trip.tripType,
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 17,
//                             fontWeight: FontWeight.w400,
//                             color: Theme.of(context).primaryColor),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         "Amount Paid",
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             widget.amount.toString(),
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.w400,
//                                     color: Theme.of(context).primaryColor),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             "(" + widget.noOfTickets.toString() + ")",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.blue),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "~Thank You For Using Bus  Stop!~",
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             fontSize: 17,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.green[900]),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.to(() => TransactionTickets(
//                         client: widget.client,
//                         transactionId: widget.transactionId,
//                       ));
//                 },
//                 child: Container(
//                   height: 45,
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: Color(0xff8c2636),
//                       )),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.airplane_ticket,
//                         color: Color(0xff8c2636),
//                         size: 20,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "View Your Tickets",
//                         style: TextStyle(
//                           fontSize: 17,
//                           color: Color(0xff8c2636),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.offAll(() => HomeView());
//                 },
//                 child: Container(
//                   height: 45,
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Color(0xff8c2636),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.home,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "Go Home",
//                         style: TextStyle(fontSize: 17, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
