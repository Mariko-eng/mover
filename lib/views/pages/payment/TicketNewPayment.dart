import 'package:bus_stop/config/collections/index.dart';
import 'package:bus_stop/config/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/models/transaction/payment.dart';
import 'package:bus_stop/models/transaction/transaction.dart';
import 'package:bus_stop/views/pages/payment/TicketPaymentSuccess.dart';
import 'package:bus_stop/views/pages/payment/TicketPaymentFailure.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';

class TicketPayment extends StatefulWidget {
  final Client client;
  final Trip trip;
  final String ticketChoice;
  final int ticketPrice;
  final int noOfTickets;
  final int totalAmount;

  const TicketPayment(
      {Key? key,
      required this.client,
      required this.trip,
      required this.ticketChoice,
      required this.ticketPrice,
      required this.noOfTickets,
      required this.totalAmount})
      : super(key: key);

  @override
  _TicketPaymentState createState() => _TicketPaymentState();
}

class _TicketPaymentState extends State<TicketPayment> {
  // final narrationController = TextEditingController();
  // final publicKeyController = TextEditingController();
  // final encryptionKeyController = TextEditingController();
  // String selectedCurrency = "UGX";
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final amountController = TextEditingController();

  bool shouldPopScreen = true;
  bool isProcessingTicket = false;

  String paymentOption = "";

  String nameError = "";
  String phoneError = "";
  String paymentOptionError = "";


  @override
  void initState() {
    setState(() {
      // isTestMode = FlutterWaveConfig.isTestMode;
      // publicKeyController.text = FlutterWaveConfig.publicKey;
      // encryptionKeyController.text = FlutterWaveConfig.encryptionKey;
      // selectedCurrency = "UGX";
      emailController.text = widget.client.email;
      amountController.text = widget.totalAmount.toString();
      // if (isTestMode == true) {
      //   publicKeyController.text =
      //       "FLWPUBK_TEST-895362a74986153380262d89bfdc9b8a-X";
      // } else {
      //   publicKeyController.text = "FLWPUBK-7b6099ed229040478723735c0ec8e1ec-X";
      //   encryptionKeyController.text = "5c86f7935b3b4596704a7520";
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // isLoading
        //   ? Scaffold(
        //       backgroundColor: Colors.white,
        //       body: Center(
        //         child: LoadingWidget(),
        //       ),
        //     )
        //   :
        PopScope(
      canPop: shouldPopScreen,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.grey[300],
            title: const Text(
              "Checkout",
              style: TextStyle(color: Color(0xffE4181D)),
            ),
            centerTitle: true,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                if (shouldPopScreen) {
                  Navigator.of(context).pop();
                }
              },
              child: SizedBox(
                  width: 20,
                  height: 25,
                  child: Image.asset(
                    'assets/images/back_arrow.png',
                  )),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ticket Holder/Buyer's Information".toUpperCase(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Number Of Tickets : ",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  Text(
                    widget.noOfTickets.toString(),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800]),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Amount : ",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  Text(
                    "SHS ${amountController.text}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900]),
                  ),
                ],
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 00, 0, 10),
                decoration: BoxDecoration(
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Your Email Address",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.blue[900]),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: emailController,
                            readOnly: true,
                            minLines: 1,
                            maxLines: 1,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                border: OutlineInputBorder()),
                            validator: (String? val) {
                              return null;
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 00, 0, 10),
                decoration: BoxDecoration(
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Enter First Name",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: nameError != ""
                                      ? Colors.red
                                      : Colors.blue[900]),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: nameController,
                            readOnly: isProcessingTicket ? true :false,
                            minLines: 1,
                            maxLines: 1,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                border: OutlineInputBorder()),
                            validator: (String? val) {
                              return null;
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  nameError == ""
                      ? Container()
                      : Container(
                          child: Row(
                            children: [
                              Text(
                                "*Required!",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 00, 0, 10),
                decoration: BoxDecoration(
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Enter Phone Number *0712312312",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: phoneError != ""
                                      ? Colors.red
                                      : Colors.blue[900]),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: phoneNumberController,
                            readOnly: isProcessingTicket ? true :false,
                            minLines: 1,
                            maxLines: 1,
                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: phoneError != ""
                                        ? Colors.red
                                        : Colors.black),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                border: OutlineInputBorder()),
                            validator: (String? val) {
                              return null;
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  phoneError == ""
                      ? Container()
                      : Container(
                          child: Row(
                            children: [
                              Text(
                                "*Required",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Card(
                    color: Color(0xffffffff),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                              width: 50,
                              height: 50,
                              child: Image.asset("assets/images/airtel.jpeg")),
                          // Icon(Icons.payment),
                          Row(
                            children: [
                              Radio(
                                  value: "airtelug",
                                  groupValue: paymentOption,
                                  onChanged: (String? val) {
                                    if (val != null) {
                                      setState(() {
                                        paymentOption = val;
                                      });
                                    }
                                  }),
                              Text("Pay with Airtel"),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Card(
                    color: Color(0xffffffff),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                              width: 50,
                              height: 50,
                              child: Image.asset("assets/images/mtn.png")),
                          // Icon(Icons.payment),
                          Row(
                            children: [
                              Radio(
                                  value: "mtnug",
                                  groupValue: paymentOption,
                                  onChanged: (String? val) {
                                    if (val != null) {
                                      setState(() {
                                        paymentOption = val;
                                      });
                                    }
                                  }),
                              Text("Pay with MTN"),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
              paymentOptionError == ""
                  ? Container()
                  : Container(
                      child: Row(
                        children: [
                          Text(
                            paymentOptionError,
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
              if (paymentOption != "")
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffE4181D)),
                          onPressed: (){
                            if(isProcessingTicket == true){
                              return;
                            }else{
                              _onPressed();
                            }
                          },
                          child: isProcessingTicket ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Please Wait!",
                                style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                              SizedBox(width: 5,),
                              SpinKitThreeInOut(color: Colors.white,)
                            ],
                          ) : Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          )),
                )
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  _onPressed() async {
    if (nameController.text.trim().length <= 2) {
      setState(() {
        nameError = "Provide A Valid Name";
      });
      return;
    } else {
      nameError = "";
    }

    if (phoneNumberController.text.trim().length < 10) {
      setState(() {
        phoneError = "Provide A Valid Phone Number";
      });
      return;
    } else {
      phoneError = "";
    }

    if (paymentOption == "") {
      setState(() {
        paymentOptionError = "Select a payment option";
      });
      return;
    } else {
      paymentOptionError = "";
    }

    String phoneNumber = phoneNumberController.text.trim();
    String lastNineDigits = phoneNumber.substring(phoneNumber.length - 9);

    try {
      setState(() {
        shouldPopScreen = false;
        isProcessingTicket = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      PaymentModel paymentResult = await buyTripTicket(
          trip: widget.trip,
          ticketType: widget.ticketChoice,
          ticketPrice: widget.ticketPrice,
          numberOfTickets: widget.noOfTickets,
          totalAmount: widget.totalAmount,
          buyerNames: nameController.text.trim(),
          buyerPhone: phoneNumberController.text.trim(),
          buyerEmail: emailController.text.trim(),
          client: widget.client,
          isTestMode: isTestMode,
          apiKey: isTestMode ? devCulipaAPIKey : prodCulipaAPIKey,
          paymentAccount: lastNineDigits,
          paymentAmount: widget.totalAmount,
          paymentWallet: paymentOption,
          paymentMemo: "${widget.trip.companyName}, ${widget.trip.tripNumber}");

      if (paymentResult.status == "SETTLED") {
        if (widget.ticketChoice == "Ordinary") {
          bool res = await purchaseOrdinaryTicket(
            preTicketId: paymentResult.transactionId,
            transactionId: paymentResult.transactionId,
            buyerNames: nameController.text.trim(),
            buyerPhoneNumber: phoneNumberController.text.trim(),
            buyerEmail: emailController.text.trim(),
            client: widget.client,
            trip: widget.trip,
            numberOfTickets: widget.noOfTickets,
            total: widget.totalAmount,
            amountPaid: widget.totalAmount,
          );
          if (res == true) {
            Get.offAll(() => PurchaseTicketSuccess(
                  transactionId: paymentResult.transactionId,
                  client: widget.client,
                  trip: widget.trip,
                  ticketChoice: widget.ticketChoice,
                  noOfTickets: widget.noOfTickets,
                  amount: widget.totalAmount,
                  buyerName: widget.client.username,
                  buyerEmail: widget.client.email,
                  buyerPhone: phoneNumberController.text.trim(),
                ));
          } else {
            Get.to(() => PurchaseTicketFailure(
                  client: widget.client,
                  trip: widget.trip,
                  ticketChoice: widget.ticketChoice,
                  noOfTickets: widget.noOfTickets,
                  amount: widget.totalAmount,
                  buyerName: widget.client.username,
                  buyerEmail: widget.client.email,
                  buyerPhone: phoneNumberController.text.trim(),
                ));
          }
        } else {
          bool res = await purchaseVIPTicket(
            preTicketId: paymentResult.transactionId,
              transactionId: paymentResult.transactionId,
            buyerNames: nameController.text.trim(),
            buyerPhoneNumber: phoneNumberController.text.trim(),
            buyerEmail: emailController.text.trim(),
            client: widget.client,
            trip: widget.trip,
            numberOfTickets: widget.noOfTickets,
            total: widget.totalAmount,
            amountPaid: widget.totalAmount,
          );

          if (res) {
            Get.offAll(() => PurchaseTicketSuccess(
              transactionId: paymentResult.transactionId,
                  client: widget.client,
                  trip: widget.trip,
                  ticketChoice: widget.ticketChoice,
                  noOfTickets: widget.noOfTickets,
                  amount: widget.totalAmount,
                  buyerName: widget.client.username,
                  buyerEmail: widget.client.email,
                  buyerPhone: phoneNumberController.text.trim(),
                ));
          } else {
            Get.to(() => PurchaseTicketFailure(
                  client: widget.client,
                  trip: widget.trip,
                  ticketChoice: widget.ticketChoice,
                  noOfTickets: widget.noOfTickets,
                  amount: widget.totalAmount,
                  buyerName: widget.client.username,
                  buyerEmail: widget.client.email,
                  buyerPhone: phoneNumberController.text.trim(),
                ));
          }
        }
      }
      if (paymentResult.status == "REFUSED") {
        _showFailureDialog(
            message: "PAYMENT REFUSED! \n The wallet network and/or the payer "
                "have failed to complete the payment!");
      }
      if (paymentResult.status == "ERROR") {
        _showFailureDialog(message: "ERROR! \n Network Failure!");
      }
      setState(() {
        shouldPopScreen = true;
        isProcessingTicket = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        shouldPopScreen = false;
        isProcessingTicket = false;
      });
      Get.snackbar("Sorry", "Failed to Complete Transaction!",
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  // _handlePaymentInitialization({required String preTicketId}) async {
  //   final Customer customer = Customer(
  //       name: widget.client.username,
  //       phoneNumber: phoneNumberController.text,
  //       email: emailController.text);
  //
  //   final Flutterwave flutterWave = Flutterwave(
  //       context: context,
  //       publicKey: publicKeyController.text,
  //       currency: selectedCurrency,
  //       redirectUrl: "https://google.com",
  //       txRef: DateTime.now().toIso8601String(),
  //       amount: amountController.text.toString().trim(),
  //       customer: customer,
  //       paymentOptions: "card, payattitude, barter",
  //       customization: Customization(title: "Bus Stop Ticket Payment"),
  //       isTestMode: isTestMode);
  //
  //   ChargeResponse response = await flutterWave.charge();
  //   print("${response.toJson()}");
  //
  //   var jsonResponse = response.toJson();
  //
  //   if (jsonResponse['status'] == "cancelled") {
  //     setState(() {
  //       isLoadingFlutterWave = false;
  //     });
  //     _showFailureDialog(
  //         message: "Payment Cancelled! \n Failed To Complete Transaction");
  //     return;
  //   }
  //
  //   if (jsonResponse['status'] == "successful") {
  //     try {
  //       setState(() {
  //         isLoading = true;
  //       });
  //       if (widget.ticketChoice == "Ordinary") {
  //         bool res = await purchaseOrdinaryTicket(
  //             preTicketId: preTicketId,
  //             buyerNames: nameController.text.trim(),
  //             buyerPhoneNumber: phoneNumberController.text.trim(),
  //             buyerEmail: emailController.text.trim(),
  //             client: widget.client,
  //             trip: widget.trip,
  //             numberOfTickets: widget.noOfTickets,
  //             total: widget.totalAmount,
  //             amountPaid: 0,
  //             status: response.status!,
  //             success: response.success!,
  //             transactionId: response.transactionId!,
  //             txRef: response.txRef!);
  //
  //         setState(() {
  //           isLoading = false;
  //           isLoadingFlutterWave = false;
  //         });
  //
  //         if (res == true) {
  //           Get.offAll(() =>
  //               PurchaseTicketSuccess(
  //                 ticketId: preTicketId,
  //                 client: widget.client,
  //                 trip: widget.trip,
  //                 ticketChoice: widget.ticketChoice,
  //                 noOfTickets: widget.noOfTickets,
  //                 amount: widget.totalAmount,
  //                 buyerName: widget.client.username,
  //                 buyerEmail: widget.client.email,
  //                 buyerPhone: phoneNumberController.text.trim(),
  //                 transactionStatus: jsonResponse['status'],
  //                 transactionId: jsonResponse['transaction_id'],
  //                 transactionTxRef: jsonResponse['tx_ref'],
  //               ));
  //         } else {
  //           Get.to(() =>
  //               PurchaseTicketFailure(
  //                 client: widget.client,
  //                 trip: widget.trip,
  //                 ticketChoice: widget.ticketChoice,
  //                 noOfTickets: widget.noOfTickets,
  //                 amount: widget.totalAmount,
  //                 buyerName: widget.client.username,
  //                 buyerEmail: widget.client.email,
  //                 buyerPhone: phoneNumberController.text.trim(),
  //                 transactionId: jsonResponse['transaction_id'],
  //                 transactionStatus: jsonResponse['status'],
  //                 transactionTxRef: jsonResponse['tx_ref'],
  //               ));
  //         }
  //       } else {
  //         bool res = await purchaseVIPTicket(
  //             preTicketId: preTicketId,
  //             buyerNames: nameController.text.trim(),
  //             buyerPhoneNumber: phoneNumberController.text.trim(),
  //             buyerEmail: emailController.text.trim(),
  //             client: widget.client,
  //             trip: widget.trip,
  //             numberOfTickets: widget.noOfTickets,
  //             total: widget.totalAmount,
  //             amountPaid: 0,
  //             status: response.status!,
  //             success: response.success!,
  //             transactionId: response.transactionId!,
  //             txRef: response.txRef!);
  //
  //         setState(() {
  //           isLoading = false;
  //           isLoadingFlutterWave = false;
  //         });
  //
  //         if (res == true) {
  //           Get.offAll(() =>
  //               PurchaseTicketSuccess(
  //                 ticketId: preTicketId,
  //                 client: widget.client,
  //                 trip: widget.trip,
  //                 ticketChoice: widget.ticketChoice,
  //                 noOfTickets: widget.noOfTickets,
  //                 amount: widget.totalAmount,
  //                 buyerName: widget.client.username,
  //                 buyerEmail: widget.client.email,
  //                 buyerPhone: phoneNumberController.text.trim(),
  //                 transactionStatus: jsonResponse['status'],
  //                 transactionId: jsonResponse['transaction_id'],
  //                 transactionTxRef: jsonResponse['tx_ref'],
  //               ));
  //         } else {
  //           Get.to(() =>
  //               PurchaseTicketFailure(
  //                 client: widget.client,
  //                 trip: widget.trip,
  //                 ticketChoice: widget.ticketChoice,
  //                 noOfTickets: widget.noOfTickets,
  //                 amount: widget.totalAmount,
  //                 buyerName: widget.client.username,
  //                 buyerEmail: widget.client.email,
  //                 buyerPhone: phoneNumberController.text.trim(),
  //                 transactionId: jsonResponse['transaction_id'],
  //                 transactionStatus: jsonResponse['status'],
  //                 transactionTxRef: jsonResponse['tx_ref'],
  //               ));
  //         }
  //       }
  //     } catch (e) {
  //       setState(() {
  //         isLoading = false;
  //         isLoadingFlutterWave = false;
  //       });
  //       Get.to(() =>
  //           PurchaseTicketFailure(
  //             client: widget.client,
  //             trip: widget.trip,
  //             ticketChoice: widget.ticketChoice,
  //             noOfTickets: widget.noOfTickets,
  //             amount: widget.totalAmount,
  //             buyerName: widget.client.username,
  //             buyerEmail: widget.client.email,
  //             buyerPhone: phoneNumberController.text.trim(),
  //             transactionId: jsonResponse['transaction_id'],
  //             transactionStatus: jsonResponse['status'],
  //             transactionTxRef: jsonResponse['tx_ref'],
  //           ));
  //     }
  //   } else {
  //     setState(() {
  //       isLoadingFlutterWave = false;
  //     });
  //     Get.to(() =>
  //         PurchaseTicketFailure(
  //           client: widget.client,
  //           trip: widget.trip,
  //           ticketChoice: widget.ticketChoice,
  //           noOfTickets: widget.noOfTickets,
  //           amount: widget.totalAmount,
  //           buyerName: widget.client.username,
  //           buyerEmail: widget.client.email,
  //           buyerPhone: phoneNumberController.text.trim(),
  //           transactionId: jsonResponse['transaction_id'],
  //           transactionStatus: jsonResponse['status'],
  //           transactionTxRef: jsonResponse['tx_ref'],
  //         ));
  //   }
  // }

  Future<void> _showFailureDialog({required String message}) async {
    await Get.defaultDialog(
        title: "",
        barrierDismissible: true,
        content: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel_outlined,
                color: Theme.of(context).primaryColor,
                size: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Sorry",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
