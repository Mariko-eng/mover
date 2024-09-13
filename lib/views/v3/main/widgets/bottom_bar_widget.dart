import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bus_stop/views/v3/main/home.dart';
import 'package:bus_stop/views/v3/main/trips.dart';
import 'package:bus_stop/views/v3/main/tickets.dart';
import 'package:bus_stop/views/v3/main/info.dart';


BottomAppBar buildBottomAppBar({required BuildContext context, required int activeBar}) {
  return BottomAppBar(
    // notchMargin: 2,
    padding: EdgeInsets.zero,
    child: Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black12
          )
        )
      ),
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if(activeBar != 0) {
                    Get.off(() => HomeView());
                  }
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
                  if(activeBar != 1) {
                    Get.off(() => TripsView());
                  }
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
                  if(activeBar != 2) {
                    Get.off(() => TicketsView());
                  }
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
                  if(activeBar != 3) {
                    Get.off(() => InfoView());
                  }
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
