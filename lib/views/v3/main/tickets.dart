import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/controllers/authController.dart';
import 'package:bus_stop/models/ticket.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';
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
    UserProvider userProvider = Provider.of<UserProvider>(context);

    final textTheme = Theme.of(context).textTheme;

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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        print("Refreshing...");
                      });
                    },
                    child: Icon(Icons.refresh,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ))
              ],
            ),
          )
        ],
      ),
      body: userProvider.client == null
          ? Center(
              child: LoadingWidget(),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(0xfffce8e8),
                        borderRadius: BorderRadius.circular(10)),
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
                                  color: isUpComing
                                      ? Color(0xffffffff)
                                      : Color(0xfffce8e8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Upcoming",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: isUpComing
                                            ? Theme.of(context).primaryColor
                                            : Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
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
                                  color: isUpComing
                                      ? Color(0xfffce8e8)
                                      : Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "History",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: isUpComing
                                            ? Colors.black
                                            : Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StreamBuilder(
                      stream: getMyTickets(uid: userProvider.client!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Expanded(
                            child: Center(
                              child: Text(
                                "Something Went Wrong!",
                                style: textTheme.bodyMedium!.copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Expanded(
                            child: Center(
                              child: LoadingWidget(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          );
                        } else {
                          List<TripTicket> allTickets = snapshot.data ?? [];

                          List<TripTicket> upcomingTickets = [];
                          List<TripTicket> historyTickets = [];

                          for (var tt in allTickets) {
                            if (tt.trip!.arrivalTime.isBefore(DateTime.now())){
                              upcomingTickets.add(tt);
                            }else {
                              historyTickets.add(tt);
                            }
                          }

                          List<TripTicket> tickets = isUpComing ? upcomingTickets : historyTickets;

                          if (tickets.isEmpty) {
                            return Expanded(
                              child: Center(
                                child: Text(
                                  "...Please Wait...",
                                  style: textTheme.bodyMedium!.copyWith(
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...tickets
                                      .map((ticket) => TicketWidget(
                                            ticket: ticket,
                                          ))
                                      .toList(),
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
      // bottomNavigationBar: buildBottomAppBar(context: context, activeBar: 2),
    );
  }
}
