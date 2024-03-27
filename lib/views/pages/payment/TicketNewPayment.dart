import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop/models/preTicket.dart';
import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';
import 'package:bus_stop/config/flutter_wave/flutter_wave_config.dart';
import 'package:bus_stop/views/pages/payment/TicketPaymentFailure.dart';
import 'package:bus_stop/views/pages/payment/TicketPaymentSuccess.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:flutterwave_standard/models/responses/charge_response.dart';

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
  final amountController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  String selectedCurrency = "UGX";

  bool isLoading = false;
  bool isLoadingFlutterWave = false;

  String nameError = "";
  String phoneError = "";

  // bool isTestMode = false;
  bool isTestMode = true;

  @override
  void initState() {
    setState(() {
      isTestMode = FlutterWaveConfig.isTestMode;
      publicKeyController.text = FlutterWaveConfig.publicKey;
      encryptionKeyController.text = FlutterWaveConfig.encryptionKey;
      selectedCurrency = "UGX";
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
    return isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: LoadingWidget(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.grey[300],
                title: const Text(
                  "Ticket Payment",
                  style: TextStyle(color: Color(0xffE4181D)),
                ),
                centerTitle: true,
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
                )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
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
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 00, 0, 10),
                    child: TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Your Name/s",
                          labelStyle: TextStyle(
                              color:
                                  nameError != "" ? Colors.red : Colors.black)),
                    ),
                  ),
                  nameError == ""
                      ? Container()
                      : Container(
                          child: Row(
                            children: [
                              Text(
                                "Required!",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 00, 0, 10),
                    child: TextFormField(
                      controller: phoneNumberController,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Your Phone Number",
                          labelStyle: TextStyle(
                              color: phoneError != ""
                                  ? Colors.red
                                  : Colors.black)),
                    ),
                  ),
                  phoneError == ""
                      ? Container()
                      : Container(
                          child: Row(
                            children: [
                              Text(
                                "Required!",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 00, 0, 10),
                    child: TextFormField(
                      readOnly: true,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: "Your Email Address",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800]),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffE4181D)),
                        onPressed: _onPressed,
                        child: isLoadingFlutterWave
                            ? CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Colors.white,
                              )
                            : Text(
                                "Pay: SHS ${amountController.text}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )
                        // child: const Text(
                        //   "Make Payment",
                        //   style: TextStyle(color: Colors.white),
                        // ),
                        ),
                  )
                ],
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
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

    if (phoneNumberController.text.trim().length >= 10) {
      try {
        setState(() {
          isLoading = true;
        });
        String docId = await addPreTripTicketData(
            client: widget.client,
            buyerNames: nameController.text.trim(),
            buyerPhoneNumber: phoneNumberController.text.trim(),
            buyerEmail: emailController.text.trim(),
            trip: widget.trip,
            ticketType: widget.ticketChoice,
            ticketPrice: widget.ticketPrice,
            totalAmount: widget.totalAmount,
            numberOfTickets: widget.noOfTickets);
        if (isLoadingFlutterWave == false) {
          await _handlePaymentInitialization(preTicketId: docId);
        }
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print(e.toString());
        setState(() {
          isLoading = false;
        });
        Get.snackbar("Failed", "Something Went Wrong!",
            colorText: Colors.white, backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar("Missing Data", "Confirm Your Phone Number",
          backgroundColor: Colors.grey);
    }
  }

  _handlePaymentInitialization({required String preTicketId}) async {
    final Customer customer = Customer(
        name: widget.client.username,
        phoneNumber: phoneNumberController.text,
        email: emailController.text);

    final Flutterwave flutterWave = Flutterwave(
        context: context,
        publicKey: publicKeyController.text,
        currency: selectedCurrency,
        redirectUrl: "https://google.com",
        txRef: DateTime.now().toIso8601String(),
        amount: amountController.text.toString().trim(),
        customer: customer,
        paymentOptions: "card, payattitude, barter",
        customization: Customization(title: "Bus Stop Ticket Payment"),
        isTestMode: isTestMode);

    ChargeResponse response = await flutterWave.charge();
    print("${response.toJson()}");

    var jsonResponse = response.toJson();

    if (jsonResponse['status'] == "cancelled") {
      setState(() {
        isLoadingFlutterWave = false;
      });
      _showFailureDialog(
          message: "Payment Cancelled! \n Failed To Complete Transaction");
      return;
    }

    if (jsonResponse['status'] == "successful") {
      try {
        setState(() {
          isLoading = true;
        });
        if (widget.ticketChoice == "Ordinary") {
          bool res = await purchaseOrdinaryTicket(
              preTicketId: preTicketId,
              buyerNames: nameController.text.trim(),
              buyerPhoneNumber: phoneNumberController.text.trim(),
              buyerEmail: emailController.text.trim(),
              client: widget.client,
              trip: widget.trip,
              numberOfTickets: widget.noOfTickets,
              total: widget.totalAmount,
              amountPaid: 0,
              status: response.status!,
              success: response.success!,
              transactionId: response.transactionId!,
              txRef: response.txRef!);

          setState(() {
            isLoading = false;
            isLoadingFlutterWave = false;
          });

          if (res == true) {
            Get.offAll(() => PurchaseTicketSuccess(
                  ticketId: preTicketId,
                  client: widget.client,
                  trip: widget.trip,
                  ticketChoice: widget.ticketChoice,
                  noOfTickets: widget.noOfTickets,
                  amount: widget.totalAmount,
                  buyerName: widget.client.username,
                  buyerEmail: widget.client.email,
                  buyerPhone: phoneNumberController.text.trim(),
                  transactionStatus: jsonResponse['status'],
                  transactionId: jsonResponse['transaction_id'],
                  transactionTxRef: jsonResponse['tx_ref'],
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
                  transactionId: jsonResponse['transaction_id'],
                  transactionStatus: jsonResponse['status'],
                  transactionTxRef: jsonResponse['tx_ref'],
                ));
          }
        } else {
          bool res = await purchaseVIPTicket(
              preTicketId: preTicketId,
              buyerNames: nameController.text.trim(),
              buyerPhoneNumber: phoneNumberController.text.trim(),
              buyerEmail: emailController.text.trim(),
              client: widget.client,
              trip: widget.trip,
              numberOfTickets: widget.noOfTickets,
              total: widget.totalAmount,
              amountPaid: 0,
              status: response.status!,
              success: response.success!,
              transactionId: response.transactionId!,
              txRef: response.txRef!);

          setState(() {
            isLoading = false;
            isLoadingFlutterWave = false;
          });

          if (res == true) {
            Get.offAll(() => PurchaseTicketSuccess(
                  ticketId: preTicketId,
                  client: widget.client,
                  trip: widget.trip,
                  ticketChoice: widget.ticketChoice,
                  noOfTickets: widget.noOfTickets,
                  amount: widget.totalAmount,
                  buyerName: widget.client.username,
                  buyerEmail: widget.client.email,
                  buyerPhone: phoneNumberController.text.trim(),
                  transactionStatus: jsonResponse['status'],
                  transactionId: jsonResponse['transaction_id'],
                  transactionTxRef: jsonResponse['tx_ref'],
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
                  transactionId: jsonResponse['transaction_id'],
                  transactionStatus: jsonResponse['status'],
                  transactionTxRef: jsonResponse['tx_ref'],
                ));
          }
        }
      } catch (e) {
        setState(() {
          isLoading = false;
          isLoadingFlutterWave = false;
        });
        Get.to(() => PurchaseTicketFailure(
              client: widget.client,
              trip: widget.trip,
              ticketChoice: widget.ticketChoice,
              noOfTickets: widget.noOfTickets,
              amount: widget.totalAmount,
              buyerName: widget.client.username,
              buyerEmail: widget.client.email,
              buyerPhone: phoneNumberController.text.trim(),
              transactionId: jsonResponse['transaction_id'],
              transactionStatus: jsonResponse['status'],
              transactionTxRef: jsonResponse['tx_ref'],
            ));
      }
    } else {
      setState(() {
        isLoadingFlutterWave = false;
      });
      Get.to(() => PurchaseTicketFailure(
            client: widget.client,
            trip: widget.trip,
            ticketChoice: widget.ticketChoice,
            noOfTickets: widget.noOfTickets,
            amount: widget.totalAmount,
            buyerName: widget.client.username,
            buyerEmail: widget.client.email,
            buyerPhone: phoneNumberController.text.trim(),
            transactionId: jsonResponse['transaction_id'],
            transactionStatus: jsonResponse['status'],
            transactionTxRef: jsonResponse['tx_ref'],
          ));
    }
  }

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
