// import 'package:bus_stop/views/v2/widgets/loading_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterwave_standard/flutterwave.dart';
// import 'package:bus_stop/models/trip.dart';
// import 'package:bus_stop/models/user.dart';
//
// class PaymentConfirmationView extends StatefulWidget {
//   final String preTicketId;
//   final Client client;
//   final Trip trip;
//   final String ticketChoice;
//   final int ticketPrice;
//   final int noOfTickets;
//   final int totalAmount;
//   final String email;
//   final String phoneNumber;
//
//   const PaymentConfirmationView({
//     super.key,
//     required this.preTicketId,
//     required this.client,
//     required this.trip,
//     required this.ticketChoice,
//     required this.ticketPrice,
//     required this.noOfTickets,
//     required this.totalAmount,
//     required this.email,
//     required this.phoneNumber,
//   });
//
//   @override
//   State<PaymentConfirmationView> createState() =>
//       _PaymentConfirmationViewState();
// }
//
// class _PaymentConfirmationViewState extends State<PaymentConfirmationView> {
//   String selectedCurrency = "UGX";
//   bool isTestMode = false;
//   final publicKeyController = TextEditingController();
//   final encryptionKeyController = TextEditingController();
//
//   bool isLoading = false;
//   String status = "pending";
//
//   @override
//   void initState() {
//     setState(() {
//       if(isTestMode == true){
//         publicKeyController.text =
//         "FLWPUBK_TEST-895362a74986153380262d89bfdc9b8a-X";
//       }else{
//         publicKeyController.text = "FLWPUBK-7b6099ed229040478723735c0ec8e1ec-X";
//         encryptionKeyController.text = "5c86f7935b3b4596704a7520";
//       }
//       selectedCurrency = "UGX";
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.grey[100],
//         iconTheme: IconThemeData(color: Colors.blue[900]),
//         centerTitle: true,
//         elevation: 0,
//         title: Container(
//           child: Image.asset(
//             "images/SailCourier_logo.png",
//             height: 80.0,
//             alignment: Alignment.center,
//           ),
//         ),
//       ),
//       body:  Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Text(
//               "Pay Now",
//               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                   fontWeight: FontWeight.w800,
//                   fontSize: 18,
//                   color: Colors.black),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: Text(
//               "Amount (UGX)",
//               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                   fontWeight: FontWeight.w800,
//                   fontSize: 18,
//                   color: Colors.black),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 widget.totalAmount.toString(),
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium!
//                     .copyWith(fontSize: 18, color: Colors.blue),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           if (isLoading)
//             LoadingWidget()
//           else if (status == "successful")
//             Container()
//           else
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isLoading = true;
//                   status = "pending";
//                 });
//                 _handlePaymentInitialization(amount: widget.totalAmount.toDouble());
//               },
//               child: Container(
//                 color: Theme.of(context).primaryColor,
//                 width: 250,
//                 height: 50,
//                 alignment: Alignment.center,
//                 child: Text(
//                   status == "cancelled" ? "Pay Again" : "Pay Now",
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyMedium!
//                       .copyWith(fontSize: 17, color: Colors.white),
//                 ),
//               ),
//             ),
//           SizedBox(
//             height: 5,
//           ),
//           if (isLoading) Text("Please wait while processing..."),
//           SizedBox(
//             height: 20,
//           ),
//           status == "pending"
//               ? Container()
//               : Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Payment Status :: ",
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyMedium!
//                       .copyWith(fontSize: 17, color: Colors.black),
//                 ),
//                 Text(
//                   status.toUpperCase(),
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyMedium!
//                       .copyWith(
//                       fontSize: 17,
//                       color: status == "successful"
//                           ? Colors.green
//                           : Colors.red),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           status == "successful" || isLoading
//               ? Container()
//               : GestureDetector(
//             onTap: () {
//               if (!isLoading) {
//                 // Get.offAll(() => HomePersonalView());
//               }
//             },
//             child: Container(
//               width: 250,
//               height: 50,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                       color: Theme.of(context).primaryColor)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.home,
//                       color: Theme.of(context).primaryColor),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     "Go Home",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium!
//                         .copyWith(
//                         fontSize: 17,
//                         color: Theme.of(context).primaryColor),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   _handlePaymentInitialization({
//     required double amount,
//   }) async {
//     final Customer customer = Customer(
//         name: widget.client.username,
//         phoneNumber: widget.phoneNumber,
//         email: widget.email);
//     try {
//       final Flutterwave flutterWave = Flutterwave(
//           context: context,
//           publicKey: publicKeyController.text,
//           currency: selectedCurrency,
//           redirectUrl: "https://google.com",
//           txRef: DateTime.now().toIso8601String(),
//           amount: widget.totalAmount.toString(),
//           customer: customer,
//           paymentOptions: "card, payattitude, barter",
//           customization: Customization(title: "Bus Stop Ticket Payment"),
//           isTestMode: isTestMode);
//
//       ChargeResponse response = await flutterWave.charge();
//
//       // print("${response.toJson()}");
//
//       var jsonResponse = response.toJson();
//
//       // transaction_id is null if transaction is not completed
//       if (jsonResponse['transaction_id'] == null) {
//         setState(() {
//           status = jsonResponse['status'];
//           isLoading = false;
//         });
//         return;
//       }
//
//       await _checkPaymentConfirmation(
//           amount: amount, transaction_id: jsonResponse['transaction_id']);
//
//     } catch (e) {
//       print(e.toString());
//       setState(() {
//         isLoading = false;
//       });
//       _showFailureDialog(message: "Transaction Failed|, Failed to make Order");
//     }
//   }
//
//   _checkPaymentConfirmation({
//     required double amount,
//     required String transaction_id,
//   }) async {
//
//     bool paymentComplete = false;
//     Map<String, dynamic> checkResult;
//
//     try {
//       do {
//         await Future.delayed(Duration(seconds: 5));
//
//         checkResult = await checkStatusOfMobilePayment(
//           isTestMode: isTestMode,
//           transaction_id: transaction_id,
//         );
//
//         if (checkResult['data']['status'] == "successful" ||
//             checkResult['data']['status'] == "cancelled") {
//           paymentComplete = true;
//         }
//       } while (!paymentComplete);
//     } catch (e) {
//       print(e.toString());
//       setState(() {
//         isLoading = false;
//         _showFailureDialog(message: 'Failed to Finish Payment Confirmation');
//       });
//       return;
//     }
//
//     if (widget.ticketChoice == "Ordinary") {
//       bool res = await purchaseOrdinaryTicket(
//           preTicketId: preTicketId,
//           client: widget.client,
//           trip: widget.trip,
//           numberOfTickets: widget.noOfTickets,
//           total: widget.totalAmount,
//           amountPaid: 0,
//           status: response.status!,
//           success: response.success!,
//           transactionId: response.transactionId!,
//           txRef: response.txRef!);
//     }else{
//       bool res = await purchaseVIPTicket(
//           preTicketId: widget.preTicketId,
//           client: widget.client,
//           trip: widget.trip,
//           numberOfTickets: widget.noOfTickets,
//           total: widget.totalAmount,
//           amountPaid: 0,
//           status: response.status!,
//           success: response.success!,
//           transactionId: response.transactionId!,
//           txRef: response.txRef!);
//     }
//
//       await updateRegularOrderOnlinePayment(
//       userModel: widget.userModel,
//       orderId: widget.orderId,
//       isActive: true,
//       paymentStatus: checkResult['data']['status'],
//       isFullyPaid: checkResult['data']['status'] == "successful" ? true : false,
//       amountPaid: amount,
//       transactionId: transaction_id,
//       transactionStatus: checkResult['data']['status'],
//       transactionPhoneNumber: widget.userModel.phone,
//       transactionDetails: checkResult,
//     );
//
//     setState(() {
//       status = checkResult['data']['status'];
//       isLoading = false;
//     });
//
//     if (checkResult['data']['status'] == "successful") {
//       await Future.delayed(Duration(seconds: 1));
//       Get.offAll(() => SuccessView(
//         orderId: widget.orderId,
//         isMobileMoneyPayment: true,
//       ));
//     }
//   }
//
//   Future<void> _showFailureDialog({required String message}) async {
//     await Get.defaultDialog(
//         title: "",
//         barrierDismissible: true,
//         content: Container(
//           height: 200,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.cancel_outlined,
//                 color: Theme.of(context).primaryColor,
//                 size: 40,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Sorry",
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Colors.black87,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 message,
//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Theme.of(context).primaryColor,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 15),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//         ));
//   }
// }