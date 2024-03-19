import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/views/shared/utils.dart';
import 'package:bus_stop/views/v2/pages/cargo/new/checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop/models/user.dart';

class SelectPickUpAndDropOffView extends StatefulWidget {
  final String packageDesc;
  final int weight;
  final String senderName;
  final String senderPhone;
  final String receiverName;
  final String receiverPhone;
  final Client client;
  const SelectPickUpAndDropOffView({super.key, required this.client, required this.packageDesc, required this.weight, required this.senderName, required this.senderPhone, required this.receiverName, required this.receiverPhone});

  @override
  State<SelectPickUpAndDropOffView> createState() =>
      _SelectPickUpAndDropOffViewState();
}

class _SelectPickUpAndDropOffViewState
    extends State<SelectPickUpAndDropOffView> {
  TextEditingController pickCtr = TextEditingController();
  TextEditingController dropCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Select Pickup & DropOff",
              style: TextStyle(fontSize: 20, color: Colors.red[900]),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.backpack_outlined,
              color: Colors.blue[900],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pickup Point",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        color: Colors.green[800],
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          child: TextField(
                            controller: pickCtr,
                            onChanged: (String val) {
                              if (val.trim().isNotEmpty) {
                                setState(() {});
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter Location",
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.blue,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DropOff Point",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        color: Colors.red[800],
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          child: TextField(
                            controller: dropCtr,
                            onChanged: (String val) {
                              if (val.trim().isNotEmpty) {
                                setState(() {});
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter Location",
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Colors.blue,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Select Your Trip",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            StreamBuilder(
                stream: getAllActiveTrips(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Expanded(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Something has Gone Wrong!"),
                        ],
                      ),
                    ));
                  }
                  if (!snapshot.hasData) {
                    return const Expanded(
                        child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ));
                  } else {
                    List<Trip>? trips = snapshot.data;
                    if (trips!.isEmpty) {
                      return Expanded(
                          child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("No Available Trips"),
                          ],
                        ),
                      ));
                    }
                    return Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListView.builder(
                          itemCount: trips.length,
                          itemBuilder: (context, int index) {
                            return FutureBuilder(
                              future: trips[index].setCompanyData(context),
                              // ignore: missing_return
                              builder: (context, snapshot) {
                                final trip = snapshot.data;

                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    if (index == 0) {
                                      // return const CircularProgressIndicator();
                                    }
                                    return Container();
                                  case ConnectionState.none:
                                    return const Text(
                                      'No Trips',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFFE4191D),
                                          fontSize: 20.0),
                                    );
                                  case ConnectionState.active:
                                    return const Text('Searching... ');
                                  case ConnectionState.done:
                                    if (trip == null) {
                                      return Container();
                                    } else {
                                      if (pickCtr.text.trim().isNotEmpty &&
                                          dropCtr.text.trim().isNotEmpty) {
                                        if (trip.departureLocationName
                                                .toLowerCase()
                                                .contains(
                                                    pickCtr.text.trim()) &&
                                            trip.arrivalLocationName
                                                .toLowerCase()
                                                .contains(
                                                    dropCtr.text.trim())) {
                                          return _buildTripCard(trip);
                                        } else {
                                          return Container();
                                        }
                                      } else {
                                        if (pickCtr.text.trim().isNotEmpty ||
                                            dropCtr.text.trim().isNotEmpty) {
                                          if (pickCtr.text.trim().isNotEmpty) {
                                            if (trip.departureLocationName
                                                .toLowerCase()
                                                .contains(
                                                    pickCtr.text.trim())) {
                                              return _buildTripCard(trip);
                                            }
                                          }
                                          if (dropCtr.text.trim().isNotEmpty) {
                                            if (trip.arrivalLocationName
                                                .toLowerCase()
                                                .contains(
                                                    dropCtr.text.trim())) {
                                              return _buildTripCard(trip);
                                            }
                                          }
                                          return Container();
                                        } else {
                                          return _buildTripCard(trip);
                                        }
                                      }
                                    }
                                }
                              },
                            );
                          }),
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildTripCard(Trip trip){
    return GestureDetector(
      onTap: () {
        Get.to(() => CargoCheckoutView(
          client: widget.client,
          trip: trip,
          packageDesc: widget.packageDesc,
          weight: widget.weight,
          senderName: widget.senderName,
          senderPhone: widget.senderPhone,
          receiverName: widget.receiverName,
          receiverPhone: widget.receiverPhone,
        ));
      },
      child: Card(
        child: ListTile(
          title: Text(
            dateToString(
                trip.departureTime),
            style: TextStyle(
                color: Colors.blue[900],
                fontSize: 12),
          ),
          trailing: Text(
              trip.companyData!['name']),
          subtitle: Row(
            mainAxisAlignment:
            MainAxisAlignment.start,
            children: [
              Text(
                trip.departureLocationName,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                    fontSize: 15,
                    color: Colors
                        .green[800],
                    fontWeight:
                    FontWeight
                        .w400),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons
                    .arrow_right_alt_rounded,
                color: Colors.blue[800],
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                trip.arrivalLocationName,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                    fontSize: 15,
                    color:
                    Colors.red[800],
                    fontWeight:
                    FontWeight
                        .w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
