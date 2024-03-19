import 'package:flutter/material.dart';
import 'package:bus_stop/models/user.dart';

class RecentOrdersView extends StatefulWidget {
  final Client client;
  const RecentOrdersView({super.key, required this.client});

  @override
  State<RecentOrdersView> createState() => _RecentOrdersViewState();
}

class _RecentOrdersViewState extends State<RecentOrdersView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        ))
      ],
    );
  }
}
