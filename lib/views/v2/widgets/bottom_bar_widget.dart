import 'package:bus_stop/views/v2/main/Home_Info_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/views/v2/main/home_view.dart';
import 'package:bus_stop/views/v2/main/home_all_trips_view.dart';
import 'package:bus_stop/views/v2/main/home_bus_company_view.dart';
import 'package:bus_stop/views/v2/main/home_ticket_view.dart';

BottomAppBar buildBottomAppBar({required BuildContext context, required int activeBar}) {
  return BottomAppBar(
    notchMargin: 2,
    child: Container(
      height: 60,
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.off(() => HomeView());
            },
            child: Column(
              children: [
                Icon(
                  Icons.home,
                  color: activeBar == 0 ? Colors.black87 :  Color(0xffE4181D),
                ),
                Text(
                  "Home",
                  style: TextStyle(
                    color: activeBar == 0 ? Colors.black87 :  Color(0xffE4181D),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => HomeAllTripsView());
            },
            child: Column(
              children: [
                Icon(Icons.bus_alert,
                  color: activeBar == 1 ? Colors.black87 :  Color(0xffE4181D),
                ),
                Text(
                  "Trips",
                  style: TextStyle(
                    color: activeBar == 1 ? Colors.black87 :  Color(0xffE4181D),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => HomeBusCompanyView());
            },
            child: Column(
              children: [
                Icon(Icons.house_siding,
                  color: activeBar == 2 ? Colors.black87 :  Color(0xffE4181D),
                ),
                Text(
                  "Bus Companies",
                  style: TextStyle(
                    color: activeBar == 2 ? Colors.black87 :  Color(0xffE4181D),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => HomeTicketView());
            },
            child: Column(
              children: [
                Icon(Icons.airplane_ticket_sharp,
                  color: activeBar == 3 ? Colors.black87 :  Color(0xffE4181D),
                ),
                 Text(
                  "My Tickets",
                  style: TextStyle(
                    color: activeBar == 3 ? Colors.black87 :  Color(0xffE4181D),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => HomeInfoView());
            },
            child: Column(
              children: [
                Icon(Icons.info,
                  color: activeBar == 3 ? Colors.black87 :  Color(0xffE4181D),
                ),
                Text(
                  "Info",
                  style: TextStyle(
                    color: activeBar == 3 ? Colors.black87 :  Color(0xffE4181D),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
