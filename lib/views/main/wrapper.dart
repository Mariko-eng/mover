import 'package:flutter/material.dart';
import 'package:bus_stop/views/main/home.dart';
import 'package:bus_stop/views/main/info.dart';
import 'package:bus_stop/views/main/tickets.dart';
import 'package:bus_stop/views/main/trips.dart';
import 'package:bus_stop/views/widgets/app_drawer.dart';
import 'package:bus_stop/views/widgets/bottom_navbar_item.dart';

class HomeWrapperView extends StatefulWidget {
  const HomeWrapperView({super.key});

  @override
  State<HomeWrapperView> createState() => _HomeWrapperViewState();
}

class _HomeWrapperViewState extends State<HomeWrapperView> {

  // static const List<Widget> _pages = <Widget>[
  //   HomeView(),
  //   TripsView(),
  //   TicketsView(),
  //   InfoView(),
  // ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> _pages = [];

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _pages = [
        HomeView(scaffoldKey: _scaffoldKey),
        TripsView(),  // Replace with your actual views
        TicketsView(), // Replace with your actual views
        InfoView(),    // Replace with your actual views
      ];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawerWidget(scaffoldKey: _scaffoldKey,),
      // body: IndexedStack(
      //   index: _currentIndex,
      //   children: _pages,
      // ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shadowColor: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BottomNavBarItem(
              iconPath: "lib/images/home.svg",
              label: "Home",
              isActive: _currentIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            BottomNavBarItem(
              iconPath: "lib/images/routing.svg",
              label: "Trips",
              isActive: _currentIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            BottomNavBarItem(
              iconPath: "lib/images/receipt-item.svg",
              label: "My Tickets",
              isActive: _currentIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            BottomNavBarItem(
              iconPath: "lib/images/information-circle.svg",
              label: "Info",
              isActive: _currentIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
