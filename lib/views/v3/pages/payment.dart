import 'package:bus_stop/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop/views/v3/main/widgets/trip.dart';
import 'package:bus_stop/views/v3/pages/payment_success.dart';

class PaymentView extends StatefulWidget {
  final Trip trip;
  final String ticketChoice;
  final int ticketChoicePrice;

  const PaymentView({Key? key, required this.trip, required this.ticketChoice, required this.ticketChoicePrice})
      : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {

  String payMethod = "";

  int noOfTickets = 1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 35,
                    color: Color(0xfff7b8b8),
                    alignment: Alignment.center,
                    child: Text(
                      "Remaining payment time : 54mins",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TripWidget(trip: widget.trip,),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Method",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15, fontWeight: FontWeight.w900, color: Colors.black),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        payMethod = "MTN";
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w900, color: Colors.black),
                            ),
                          ],
                        ),
                        Radio(
                            value: "MTN",
                            groupValue: payMethod,
                            onChanged: (String? val) {
                              setState(() {
                                payMethod = val!;
                              });
                            })
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        payMethod = "Airtel";
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w900, color: Colors.black),
                            ),
                          ],
                        ),
                        Radio(
                            value: "Airtel",
                            groupValue: payMethod,
                            onChanged: (String? val) {
                              setState(() {
                                payMethod = val!;
                              });
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Number of tickets",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w900, color: Colors.black),
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: () {
                          if (noOfTickets > 1) {
                            setState(() {
                              noOfTickets--;
                            });
                          }
                        },
                          child: Text("-",
                          style: TextStyle(fontSize: 30, color: Colors.red[800]),
                          )),
                      SizedBox(width: 10,),
                      Text(noOfTickets.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            noOfTickets++;
                          });
                        },
                          child: Icon(Icons.add, color: Colors.blue[800]))
                    ],
                  ),
                  SizedBox(height: 10,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mobile Number",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w900, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(child: TextField(
                            minLines: 1,
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: "0712 121212",
                              border: OutlineInputBorder(),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(top: 10,right: 10),
                                child: Text("Change",
                                  style: textTheme.bodyMedium!.copyWith(
                                    fontSize: 15,
                                      color: Colors.red[800],
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              )
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.to(() => PaymentSuccessfulView());
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xffcd181a),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Pay 60,000 SHS",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}