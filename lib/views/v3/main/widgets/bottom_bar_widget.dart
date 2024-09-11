import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:bus_stop/views/main/Home_Info_view.dart';
// import 'package:bus_stop/views/main/home_view.dart';
// import 'package:bus_stop/views/main/home_all_trips_view.dart';
// import 'package:bus_stop/views/main/home_bus_company_view.dart';
// import 'package:bus_stop/views/main/home_ticket_view.dart';

BottomAppBar buildBottomAppBar({required BuildContext context, required int activeBar}) {
  return BottomAppBar(
    // notchMargin: 2,
    // padding: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
    padding: EdgeInsets.zero,
    child: Container(
      height: 60,
      color: Colors.grey[100],
      // alignment: Alignment.center,
      // padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: EdgeInsets.only(left: 10,right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // Get.off(() => HomeView());
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.home,
                      color: activeBar == 0 ? Colors.blue[800] :  Color(0xffE4181D),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 17,
                        color: activeBar == 0 ? Colors.blue[800] :  Color(0xffE4181D),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Get.to(() => HomeAllTripsView());
                },
                child: Column(
                  children: [
                    Icon(Icons.bus_alert,
                      color: activeBar == 1 ? Colors.black87 :  Color(0xffE4181D),
                    ),
                    Text(
                      "Trips",
                      style: TextStyle(
                        fontSize: 17,
                        color: activeBar == 1 ? Colors.black87 :  Color(0xffE4181D),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Get.to(() => HomeTicketView());
                },
                child: Column(
                  children: [
                    Icon(Icons.airplane_ticket_sharp,
                      color: activeBar == 3 ? Colors.black87 :  Color(0xffE4181D),
                    ),
                     Text(
                      "My Tickets",
                      style: TextStyle(
                        fontSize: 17,
                        color: activeBar == 3 ? Colors.black87 :  Color(0xffE4181D),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Get.to(() => HomeInfoView());
                },
                child: Column(
                  children: [
                    Icon(Icons.info,
                      color: activeBar == 3 ? Colors.black87 :  Color(0xffE4181D),
                    ),
                    Text(
                      "What's New",
                      style: TextStyle(
                        fontSize: 17,
                        color: activeBar == 3 ? Colors.black87 :  Color(0xffE4181D),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
