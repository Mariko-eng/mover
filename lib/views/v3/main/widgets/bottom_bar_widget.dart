import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                    SvgPicture.asset(
                      "lib/images/home.svg",
                      width: 30,
                      height: 30,
                      colorFilter: ColorFilter.mode(activeBar == 0 ? Theme.of(context).primaryColor : Colors.black, BlendMode.srcIn),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 15,
                        color: activeBar == 0 ? Theme.of(context).primaryColor :  Colors.black,
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
                    SvgPicture.asset(
                      "lib/images/routing.svg",
                      width: 30,
                      height: 30,
                      colorFilter: ColorFilter.mode(activeBar == 1 ? Theme.of(context).primaryColor : Colors.black, BlendMode.srcIn),
                    ),
                    Text(
                      "Trips",
                      style: TextStyle(
                        fontSize: 15,
                        color: activeBar == 1 ? Theme.of(context).primaryColor :  Colors.black,
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
                    SvgPicture.asset(
                      "lib/images/receipt-item.svg",
                      width: 30,
                      height: 30,
                      colorFilter: ColorFilter.mode(activeBar == 2 ? Theme.of(context).primaryColor : Colors.black, BlendMode.srcIn),
                    ),
                    Text(
                      "My Tickets",
                      style: TextStyle(
                        fontSize: 15,
                        color: activeBar == 2 ? Theme.of(context).primaryColor :  Colors.black,
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
                    SvgPicture.asset(
                      "lib/images/information-circle.svg",
                      width: 30,
                      height: 30,
                      colorFilter: ColorFilter.mode(activeBar == 3 ? Theme.of(context).primaryColor : Colors.black, BlendMode.srcIn),
                    ),
                    Text(
                      "Info",
                      style: TextStyle(
                        fontSize: 15,
                        color: activeBar == 3 ? Theme.of(context).primaryColor :  Colors.black,
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
