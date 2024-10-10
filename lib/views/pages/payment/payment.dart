import 'package:bus_stop/views/widgets/ticket_time_countdown.dart';
import 'package:bus_stop/views/widgets/trip_payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bus_stop/config/collections/index.dart';
import 'package:bus_stop/config/shared/constants.dart';
import 'package:bus_stop/controllers/authController.dart';
import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/models/transaction/payment.dart';
import 'package:bus_stop/models/transaction/transaction.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';
import 'package:bus_stop/views/pages/payment/payment_success.dart';

class PaymentView extends StatefulWidget {
  final Trip trip;
  final String ticketChoice;
  final int ticketChoicePrice;

  const PaymentView(
      {Key? key,
      required this.trip,
      required this.ticketChoice,
      required this.ticketChoicePrice})
      : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final TextEditingController _nameCtr = TextEditingController();
  final TextEditingController _phoneCtr = TextEditingController();

  String payMethod = "";

  int noOfTickets = 1;

  bool _canPopScreen = true;
  bool _isProcessingTicket = false;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final textTheme = Theme.of(context).textTheme;

    int finalTicketsCharges = widget.ticketChoicePrice * noOfTickets;

    return PopScope(
      canPop: _canPopScreen,
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffffffff),
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Payment",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: userProvider.client == null
            ? const Center(
                child: LoadingWidget(),
              )
            : KeyboardDismisser(
                gestures: [
                  GestureType.onTap,
                  GestureType.onVerticalDragDown,
                  GestureType.onPanUpdateDownDirection,
                ],
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TicketTimeCountdownWidget(
                              departureDate: widget.trip.departureTime,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TripPaymentWidget(
                          trip: widget.trip,
                          ticketChoice: widget.ticketChoice,
                          ticketChoicePrice: widget.ticketChoicePrice,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Method",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_isProcessingTicket == false) {
                                  setState(() {
                                    payMethod = "mtnug";
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "lib/images/mtn.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                      Text(
                                        "MTN",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Radio(
                                      value: "mtnug",
                                      groupValue: payMethod,
                                      onChanged: (String? val) {
                                        if (_isProcessingTicket == false) {
                                          setState(() {
                                            payMethod = val!;
                                          });
                                        }
                                      })
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_isProcessingTicket == false) {
                                  setState(() {
                                    payMethod = "airtelug";
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "lib/images/airtel.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                      Text(
                                        "Airtel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Radio(
                                      value: "airtelug",
                                      groupValue: payMethod,
                                      onChanged: (String? val) {
                                        if (_isProcessingTicket == false) {
                                          setState(() {
                                            payMethod = val!;
                                          });
                                        }
                                      })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Number of tickets",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (noOfTickets > 1 &&
                                          _isProcessingTicket == false) {
                                        setState(() {
                                          noOfTickets--;
                                        });
                                      }
                                    },
                                    child: Icon(Icons.remove_circle,
                                        color: Colors.red[800])),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  noOfTickets.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (_isProcessingTicket == false) {
                                        setState(() {
                                          noOfTickets++;
                                        });
                                      }
                                    },
                                    child: Icon(Icons.add_circle,
                                        color: Colors.blue[800]))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Buyer Name/s",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: TextField(
                                      minLines: 1,
                                      maxLines: 1,
                                      controller: _nameCtr,
                                      readOnly: _isProcessingTicket,
                                      decoration: InputDecoration(
                                          hintText: "Enter first & last name",
                                          border: OutlineInputBorder(),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Text(
                                              "Change",
                                              style: textTheme.bodyMedium!
                                                  .copyWith(
                                                      fontSize: 15,
                                                      color: Colors.red[800],
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          )),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mobile Number",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: TextField(
                                      minLines: 1,
                                      maxLines: 1,
                                      controller: _phoneCtr,
                                      readOnly: _isProcessingTicket,
                                      decoration: InputDecoration(
                                          hintText: "0712 121212",
                                          border: OutlineInputBorder(),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, right: 10),
                                            child: Text(
                                              "Change",
                                              style: textTheme.bodyMedium!
                                                  .copyWith(
                                                      fontSize: 15,
                                                      color: Colors.red[800],
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                          )),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (payMethod == "") {
                                          Fluttertoast.showToast(
                                              msg: "Select Payment Method");
                                          return;
                                        }
                                        if (_nameCtr.text.length < 2) {
                                          Fluttertoast.showToast(
                                              msg: "Enter Your Valid Name/s");
                                          return;
                                        }
                                        if (_phoneCtr.text.length < 10) {
                                          Fluttertoast.showToast(
                                              msg: "Enter Your Phone Number");
                                          return;
                                        }
                                        if (_isProcessingTicket == true) {
                                          return;
                                        } else {
                                          _onPressed(
                                              client: userProvider.client!,
                                              finalCharges:
                                                  finalTicketsCharges);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color(0xffcd181a),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: _isProcessingTicket
                                            ? const LoadingWidget(
                                                color: Colors.white,
                                              )
                                            : Text(
                                                "Pay SHS $finalTicketsCharges",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w900,
                                                        fontSize: 18,
                                                        color: Colors.white),
                                              ),
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
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _onPressed({required Client client, required int finalCharges}) async {
    String phoneNumber = _phoneCtr.text.trim();
    String lastNineDigits = phoneNumber.substring(phoneNumber.length - 9);

    try {
      setState(() {
        _canPopScreen = false;
        _isProcessingTicket = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      PaymentModel paymentResult = await buyTripTicket(
          trip: widget.trip,
          ticketType: widget.ticketChoice,
          ticketPrice: widget.ticketChoicePrice,
          numberOfTickets: noOfTickets,
          totalAmount: finalCharges,
          buyerNames: _nameCtr.text.trim(),
          buyerPhone: _phoneCtr.text.trim(),
          buyerEmail: client.email,
          client: client,
          isTestMode: isTestMode,
          apiKey: isTestMode ? devCulipaAPIKey : prodCulipaAPIKey,
          paymentAccount: lastNineDigits,
          paymentAmount: finalCharges,
          paymentWallet: payMethod,
          paymentMemo: "${widget.trip.companyName}, ${widget.trip.tripNumber}");

      if (paymentResult.status == "SETTLED") {
        if (widget.ticketChoice == "Ordinary") {
          bool res = await purchaseOrdinaryTicket(
            preTicketId: paymentResult.transactionId,
            transactionId: paymentResult.transactionId,
            buyerNames: _nameCtr.text.trim(),
            buyerPhoneNumber: _phoneCtr.text.trim(),
            buyerEmail: client.email,
            client: client,
            trip: widget.trip,
            numberOfTickets: noOfTickets,
            total: finalCharges,
            amountPaid: finalCharges,
          );
          if (res == true) {
            Get.offAll(() => PaymentSuccessfulView(
                  transactionId: paymentResult.transactionId,
                  client: client,
                  trip: widget.trip,
                  ticketChoice: widget.ticketChoice,
                  noOfTickets: noOfTickets,
                  amountPaid: finalCharges,
                  buyerName: client.username,
                  buyerEmail: client.email,
                  buyerPhone: _phoneCtr.text.trim(),
                ));
          } else {
            setState(() {
              _canPopScreen = true;
              _isProcessingTicket = false;
            });
            _showFailureDialog(
                message:
                    "ERROR! \n Failed to process ticket! \n Contact Support!!");
          }
        } else {
          bool res = await purchaseVIPTicket(
            preTicketId: paymentResult.transactionId,
            transactionId: paymentResult.transactionId,
            buyerNames: _nameCtr.text.trim(),
            buyerPhoneNumber: _phoneCtr.text.trim(),
            buyerEmail: client.email,
            client: client,
            trip: widget.trip,
            numberOfTickets: noOfTickets,
            total: finalCharges,
            amountPaid: finalCharges,
          );

          if (res) {
            Get.offAll(() => PaymentSuccessfulView(
                  transactionId: paymentResult.transactionId,
                  client: client,
                  trip: widget.trip,
                  ticketChoice: widget.ticketChoice,
                  noOfTickets: noOfTickets,
                  amountPaid: finalCharges,
                  buyerName: client.username,
                  buyerEmail: client.email,
                  buyerPhone: _phoneCtr.text.trim(),
                ));
          } else {
            setState(() {
              _canPopScreen = true;
              _isProcessingTicket = false;
            });
            _showFailureDialog(
                message:
                    "ERROR! \n Failed to process ticket! \n Contact Support!!");
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
        _canPopScreen = true;
        _isProcessingTicket = false;
      });
    } catch (e) {
      setState(() {
        _canPopScreen = false;
        _isProcessingTicket = false;
      });
      _showFailureDialog(message: "Failed to Complete Transaction!");
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
