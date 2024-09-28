import 'package:flutter/material.dart';
import 'package:bus_stop/views/v3/main/widgets/bottom_bar_widget.dart';
import 'package:bus_stop/views/v3/main/widgets/ticket_widget.dart';

class TicketsView extends StatefulWidget {
  const TicketsView({super.key});

  @override
  State<TicketsView> createState() => _TicketsViewState();
}

class _TicketsViewState extends State<TicketsView> {
  bool isUpComing = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "My Tickets",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    color: Color(0xfffce8e8),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isUpComing = true;
                          });
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isUpComing ? Color(0xffffffff) :  Color(0xfffce8e8),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            "Upcoming",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: isUpComing ? Theme.of(context).primaryColor :  Colors.black,
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isUpComing = false;
                          });
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: isUpComing ? Color(0xfffce8e8) :  Color(0xffffffff),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(
                            "History",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: isUpComing ? Colors.black : Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              TicketWidget()
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context: context, activeBar: 2),
    );
  }
}
