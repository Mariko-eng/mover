import 'package:bus_stop/models/busCompany.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/views/pages/bus_company/BusCompanyMyTickets.dart';
import 'package:bus_stop/views/pages/bus_company/BusCompanyProfile.dart';
import 'package:flutter/material.dart';

import 'BusCompanyDestinations.dart';
import 'BusCompanyTrips.dart';

class BusCompanyScreen extends StatefulWidget {
  final Client client;

  const BusCompanyScreen({Key? key, required this.client}) : super(key: key);

  @override
  _BusCompanyScreenState createState() => _BusCompanyScreenState();
}

class _BusCompanyScreenState extends State<BusCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfffdfdfd),
          elevation: 0,
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
          title: Text(
            "Select Bus Company".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      body: StreamBuilder(
        stream: getAllBusCompanies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            List<BusCompany>? data = snapshot.data;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Name : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(data[index].name)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Email : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(data[index].email)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Phone Number : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(data[index].phoneNumber)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BusCompanyTrips(
                                                      client: widget.client,
                                                      company: data[index],
                                                    )));
                                      },
                                      child: Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "View Trips",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.blue[900],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BusCompanyMyTickets(
                                                      client: widget.client,
                                                      company: data[index],
                                                    )));
                                      },
                                      child: Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "View Tickets",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.red[900],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _openBottomSheet(company: data[index]);
                                    },
                                    child: Container(
                                      height: 30,
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "More",
                                        style:
                                            TextStyle(color: Colors.red[900]),
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red[900]!),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _openBottomSheet({required BusCompany company}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getTicketOptions(company: company);
        });
  }

  Widget _getTicketOptions({required BusCompany company}) {
    final options = ["Destinations", "Bus Company Profile"];
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) => ListTile(
                  onTap: () => {
                    if (option == "Destinations")
                      {
                        Navigator.of(context).pop(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BusCompanyDestinations(
                                      company: company,
                                    )))
                      },
                    if (option == "Bus Company Profile")
                      {
                        Navigator.of(context).pop(),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BusCompanyProfile(
                                      company: company,
                                    )))
                      }
                  },
                  title: Column(
                    children: [
                      Text(
                        option,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Color(0xFFE4191D)),
                      ),
                      const SizedBox(height: 4),
                      const Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
