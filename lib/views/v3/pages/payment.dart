import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {

  String payMethod = "";

  int noOfTickets = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
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
            TripWidget(),
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
                            decoration: InputDecoration(
                              hintText: "0712 121212",
                              border: OutlineInputBorder()
                            ),
                          )),
                        ],
                      ),
                    ],
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

class TripWidget extends StatefulWidget {
  const TripWidget({super.key});

  @override
  State<TripWidget> createState() => _TripWidgetState();
}

class _TripWidgetState extends State<TripWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
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
                    offset: Offset(0, 2), // changes position of shadow
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
                          "Thausi Coaches UG",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 18),
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
                                "Kampala Kampala Kampala",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "08:00 AM",
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
                                "Masaka",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "08:00 AM",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w400),
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
                    height: 30,
                    width: 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              offset: Offset(1, 0)),
                          BoxShadow(
                              color: Colors.white, offset: Offset(-15, 0)),
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
                                decoration:
                                    BoxDecoration(color: Colors.black54),
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
                    height: 30,
                    width: 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        // border: Border(
                        //   right: BorderSide(color: Colors.white)
                        // ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
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
              height: 80,
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
                    offset: Offset(0, 15), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xffcd181a),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "60,000 SHS",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
