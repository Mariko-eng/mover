import 'dart:async';
import 'package:flutter/material.dart';

class TicketTimeCountdownWidget extends StatefulWidget {
  final DateTime departureDate;
  const TicketTimeCountdownWidget({super.key, required this.departureDate});

  @override
  State<TicketTimeCountdownWidget> createState() => _TicketTimeCountdownWidgetState();
}

class _TicketTimeCountdownWidgetState extends State<TicketTimeCountdownWidget> {

  late Timer _timer;
  late int remainingTimeInSeconds = 0;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        Duration remainingTime = widget.departureDate.difference(DateTime.now());
        remainingTimeInSeconds = remainingTime.inSeconds;

        if (remainingTime.isNegative) {
          remainingTimeInSeconds = 0;
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer safely
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return remainingTimeInSeconds == 0 ? Container() : Container(
      height: 35,
      color: Color(0xfff7b8b8),
      alignment: Alignment.center,
      child: Text(
        "Remaining payment time : $remainingTimeInSeconds secs",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black),
      ),
    );
  }
}