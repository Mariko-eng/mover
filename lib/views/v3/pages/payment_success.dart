import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/v3/main/home.dart';
import 'package:bus_stop/views/v3/main/widgets/ticket_widget.dart';

class PaymentSuccessfulView extends StatefulWidget {
  final String transactionId;
  final Client client;
  final Trip trip;
  final String ticketChoice;
  final int noOfTickets;
  final int amountPaid;
  final String buyerName;
  final String buyerEmail;
  final String buyerPhone;

  const PaymentSuccessfulView({
    Key? key,
    required this.transactionId,
    required this.client,
    required this.trip,
    required this.ticketChoice,
    required this.noOfTickets,
    required this.amountPaid,
    required this.buyerName,
    required this.buyerEmail,
    required this.buyerPhone,
  }) : super(key: key);

  @override
  State<PaymentSuccessfulView> createState() => _PaymentSuccessfulViewState();
}

class _PaymentSuccessfulViewState extends State<PaymentSuccessfulView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.green[800],
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Icon(Icons.check,
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Booking successful!",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(
                        fontSize: 17,
                        color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Your payment was received",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(
                        fontSize: 17,
                        color: Colors.grey[900]
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${widget.amountPaid} shs",
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium!.copyWith(
                        fontSize: 17,
                        color: Colors.grey[900]
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),

              TicketWidget(),

              SizedBox(height: 50,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.offAll(() => const HomeView());
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xffcd181a),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Go Home",
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
              SizedBox(height: 10,)

            ],
          ),
        ),
      ),
    );
  }
}
