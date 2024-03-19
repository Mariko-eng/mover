import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';

class PurchaseTicketFailure extends StatefulWidget {
  final Client client;
  final Trip trip;
  final String ticketChoice;
  final int noOfTickets;
  final int amount;
  final String buyerName;
  final String buyerEmail;
  final String buyerPhone;
  final String transactionId;
  final String transactionStatus;
  final String transactionTxRef;

  const PurchaseTicketFailure({Key? key,
    required this.client,
    required this.trip,
    required this.ticketChoice,
    required this.noOfTickets,
    required this.amount,
    required this.buyerName,
    required this.buyerEmail,
    required this.buyerPhone,
    required this.transactionId,
    required this.transactionStatus,
    required this.transactionTxRef,
  }) : super(key: key);

  @override
  _PurchaseTicketFailureState createState() => _PurchaseTicketFailureState();
}

class _PurchaseTicketFailureState extends State<PurchaseTicketFailure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFEFDF8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          "Failed To Complete Ticket Purchase!",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xff8c2636)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cancel,
                      size: 100,color: Colors.red[700],)
                  ],
                ),
                SizedBox(height: 30,),
                Column(
                  children: [
                    Text("Trip",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    Text(widget.trip.tripNumber,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.trip.departureLocationName,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor
                          ),
                        ),
                        Icon(Icons.arrow_circle_right,
                          color: Colors.blue[900],
                        ),
                        Text(widget.trip.arrivalLocationName,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor
                          ),
                        )
                      ],
                    ),
                    Text("Company",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(widget.trip.companyData!['name'],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Column(
                  children: [
                    Text("Ticket Type",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    Text(widget.trip.tripType,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Column(
                  children: [
                    Text("Amount Paid",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.amount.toString(),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).primaryColor
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text("(" +widget.noOfTickets.toString() + ")",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Column(
                  children: [
                    Text("Transaction Tax Ref",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    Text(widget.transactionTxRef,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Column(
                  children: [
                    Text("Transaction Status",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    Text(widget.transactionStatus.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                widget.transactionStatus.toLowerCase() == 'successful' ?
                Column(
                  children: [
                    Text("Ticket Generation Status",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    Text("Sorry, Failed!",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                  ],
                ) : Container(),
                SizedBox(height: 5,),
              ],
            ),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xff8c2636),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 10,),
                    Text("Try Again",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
