import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop/models/info.dart';
import 'package:bus_stop/views/pages/info/info_detail.dart';

class InfoView extends StatefulWidget {
  const InfoView({super.key});

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          flexibleSpace: SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Booking Information",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TabBar(
                        // controller: _tabController,
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 2,
                        indicatorColor: Theme.of(context).primaryColor,
                        labelColor: Colors.black,
                        dividerColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(text: "News"),
                          Tab(text: "FAQs"),
                          Tab(text: "Terms & Conditions"),
                          Tab(text: "Cancellation Policy"),
                        ],
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 17, color: Colors.yellow[100]),
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: TabBarView(
            children: [
              tabNews(context),
              tabFAQs(context),
              tabTermsAndConditions(context),
              tabCancellationPolicy(context),

              // tabNews(context),
              // tabFAQs(context),
              // tabTermsAndConditions(context),
            ],
          ),
        ),
        // bottomNavigationBar: buildBottomAppBar(context: context, activeBar: 3),
      ),
    );
  }
}

Widget tabNews(BuildContext context) {
  return Column(
    children: [
      StreamBuilder<Object>(
          stream: getAllInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Expanded(
                  child: Center(child: Text("Something Went Wrong!")));
            }
            if (snapshot.hasData) {
              List<InfoModel> data = snapshot.data as List<InfoModel>;
              if (data.isEmpty) {
                return Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 270,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                child: Image.asset(
                                  'assets/images/image11.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                height: 270,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                  Border.all(color: Colors.black26),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.35, 0.95, 1.0],
                                    colors: [
                                      Colors.transparent,
                                      Colors.black87,
                                      Colors.black,
                                      // Dark color at the bottom (adjust opacity as needed)
                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bus Stop",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Welcome to Bus Stop",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() =>
                                  InfoDetailView(infoModel: data[index]));
                            },
                            child: Container(
                              height: 270,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: Hero(
                                          tag: data[index].id,
                                          child: Image.network(
                                              data[index].imageUrl)),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      height: 270,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.black26),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [0.35, 0.95, 1.0],
                                          colors: [
                                            Colors.transparent,
                                            Colors.black87,
                                            Colors.black,
                                            // Dark color at the bottom (adjust opacity as needed)
                                          ],
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].title,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            data[index].subTitle,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }));
            }
            return Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.red,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 270,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              child: Image.asset(
                                'assets/images/image11.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: 270,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black26),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.35, 0.95, 1.0],
                                  colors: [
                                    Colors.transparent,
                                    Colors.black87,
                                    Colors.black,
                                    // Dark color at the bottom (adjust opacity as needed)
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bus Stop",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Welcome to Bus Stop",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    ],
  );
}

Widget tabTermsAndConditions(BuildContext context) {
  return ListView(
    children: [
      buildWidget(
          context: context,
          title: "General terms",
          desc:
              "By booking a ticket, you agree to be bound by these terms and conditions. The booking is subject to availability and acceptance by the bus operator."),

      buildWidget(
          context: context,
          title: "Booking Process",
          desc:
          "All bookings made through our official App, A digital ticket or QR code will be used to board a bus. "),

      buildWidget(
          context: context,
          title: "Payment",
          desc:
          "Full payment must be made at the time of booking. Accepted payment methods include credit/debit cards and mobile money."),

      buildWidget(
          context: context,
          title: "Changes to booking",
          desc:
          "Any changes to the booking must be requested at least 24 hours before departure. Changes are subject to availability and may incur additional charges."),

      buildWidget(
          context: context,
          title: "Luggage",
          desc:
          "Each passenger is responsible for their own luggage. The bus operator is not liable for any loss, damage, or theft of luggage. Excess or oversized luggage may incur additional charges."),

    ],
  );
}

Widget tabCancellationPolicy(BuildContext context) {
  return ListView(
    children: [
      buildWidget(
          context: context,
          title: "General terms",
          desc:
              "This policy applies to all ticket bookings. By booking a ticket, you agree to the terms outlined in this refund and cancellation policy."),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Text(
            "Cancellation by Passenger",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(
                fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(height: 5,),
          RichText(text: TextSpan(
            children: [
              TextSpan(text: "Notice period : ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                  color: Colors.black,
                    fontWeight: FontWeight.bold, fontSize: 15),
              ),
              TextSpan(text: "Cancellations must be made at least 24 hours before the scheduled departure time to be eligible for a refund.",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400, fontSize: 15),
              ),
            ]
          )),
          RichText(text: TextSpan(
              children: [
                TextSpan(text: "Cancellation fee : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "A cancellation fee of 10% of the ticket price will be deducted from the refund amount.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ]
          )),
          RichText(text: TextSpan(
              children: [
                TextSpan(text: "Non-refundable : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "A cancellation fee of 10% of the ticket price will be deducted from the refund amount.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ]
          )),
          SizedBox(height: 5,),
        ],
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Text(
            "Cancellation by Operator",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(
                fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(height: 5,),
          RichText(text: TextSpan(
              children: [
                TextSpan(text: "Full Refund : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "Full Refund: If the bus operator cancels the trip, passengers are entitled to a full refund of the ticket price.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ]
          )),
          RichText(text: TextSpan(
              children: [
                TextSpan(text: "Alternative arrangements : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "The bus operator may offer an alternative travel arrangement at no additional cost to the passenger.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ]
          )),
          SizedBox(height: 5,),
        ],
      ),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Text(
            "Process for refunds",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(
                fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(height: 5,),
          RichText(text: TextSpan(
              children: [
                TextSpan(text: "Request : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "Passengers must submit a refund request through our official website or authorized agents.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ]
          )),
          RichText(text: TextSpan(
              children: [
                TextSpan(text: "Processing Time :",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "Refunds will be processed within 14 business days from the date of the cancellation request.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ]
          )),
          RichText(text: TextSpan(
              children: [
                TextSpan(text: "Payment method : ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(text: "Refunds will be issued using the original payment method.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ]
          )),
          SizedBox(height: 5,),
        ],
      ),

    ],
  );
}

Widget tabFAQs(BuildContext context) {
  return ListView(
    children: [
      buildWidget(
          context: context,
          title: "1. How do i book a bus ticket?",
          desc:
              "You can book a bus ticket through our official Mobile application. Select your desired route, travel date, and passenger details. Complete the payment process to receive a booking confirmation via email."),

      buildWidget(
          context: context,
          title: "2. Can I change my booking after it has been confirmed?",
          desc:
          "Yes, changes to your booking can be requested at least 24 hours before the scheduled departure. Please note that changes are subject to availability and may incur additional charges."),

      buildWidget(
          context: context,
          title: "3. How do I receive a refund after canceling my ticket?",
          desc:
          "To receive a refund, submit a refund request through our official App. Refunds will be processed within 14 business days from the date of the cancellation request and will be issued using the original payment method."),

      buildWidget(
          context: context,
          title: "4. What should i do if i lose my luggage during the trip",
          desc:
          "Each passenger is responsible for their own luggage. The bus operator is not liable for any loss, damage, or theft of luggage. We recommend labeling your luggage with your contact information and keeping valuable items with you at all times."),
    ],
  );
}


Column buildWidget(
    {required BuildContext context,
    required String title,
    required String desc}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 5,),
      Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(
            fontWeight: FontWeight.bold, fontSize: 17),
      ),
      SizedBox(height: 5,),
      Text(
        desc,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
      ),
      SizedBox(height: 5,),
    ],
  );
}
