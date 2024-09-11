import 'package:flutter/material.dart';
import 'package:bus_stop/views/v3/main/home.dart';
import 'package:bus_stop/views/v3/main/widgets/bottom_bar_widget.dart';

class HomeWrapper2 extends StatefulWidget {
  const HomeWrapper2({super.key});

  @override
  State<HomeWrapper2> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeView(),
      bottomNavigationBar: buildBottomAppBar(context: context, activeBar: 1),
    );
  }
}
