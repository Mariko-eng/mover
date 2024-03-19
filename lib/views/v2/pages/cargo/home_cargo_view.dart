import 'package:bus_stop/views/v2/pages/cargo/new/new_order_view.dart';
import 'package:bus_stop/views/v2/pages/cargo/recent/recent_orders_view.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/user.dart';

class HomeCargoView extends StatefulWidget {
  final Client client;
  const HomeCargoView({super.key, required this.client});

  @override
  State<HomeCargoView> createState() => _HomeCargoViewState();
}

class _HomeCargoViewState extends State<HomeCargoView> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xfffdfdfd),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
                width: 20,
                height: 25,
                child: Image.asset(
                  'assets/images/back_arrow.png',
                )),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "My Cargo Section",
                style: TextStyle(
                  fontSize: 20,
                    color: Colors.red[900]),
              ),
              const SizedBox(width: 5,),
              Icon(
                Icons.backpack_outlined,
                color: Colors.blue[900],
              ),
            ],
          ),
        ),
        body: Column(
                children: [
                  TabBar(
                      tabs: [
                        Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: Text("Send Cargo",
                              style: TextStyle(
                                  color: Colors.red[900],
                                  fontSize: 17
                              ),
                            )),
                        Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: Text("Recent Orders",
                              style: TextStyle(
                                  color: Colors.red[900],
                                  fontSize: 17
                              ),
                            ))
                      ]),
                  Expanded(child: TabBarView(
                    children: [
                      NewCargoOrderView(client: widget.client),
                      RecentOrdersView(client: widget.client),
                    ],
                  ))
                ],
              ),
      ),
    );
  }
}
