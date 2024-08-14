import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCargoCheckoutView extends StatefulWidget {
  const NewCargoCheckoutView({super.key});

  @override
  State<NewCargoCheckoutView> createState() => _NewCargoCheckoutState();
}

class _NewCargoCheckoutState extends State<NewCargoCheckoutView> {
  String orderPayer = "";

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150 + statusBarHeight,
        backgroundColor: Theme.of(context).primaryColor,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back(); // Navigate back if on the first page
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "New Order Checkout",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Please Complete The Steps Make Your Order",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 15, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Payer",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        Text("Who is paying for the order?"),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                    value: "sender",
                                    groupValue: orderPayer,
                                    onChanged: (String? val) {
                                      setState(() {
                                        orderPayer = "sender";
                                      });
                                    }),
                                Text("Sender"),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                Radio(
                                    value: "receiver",
                                    groupValue: orderPayer,
                                    onChanged: (String? val) {
                                      setState(() {
                                        orderPayer = "receiver";
                                      });
                                    }),
                                Text("Receiver"),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Payment",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery charges",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "SHS 5000",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Package size charges",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "SHS 5000",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sub total",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "SHS 5000",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "SHS 5000",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "SHS 5000",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text("Place Order",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
