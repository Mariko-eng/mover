import 'package:flutter/material.dart';
import 'package:bus_stop/views/pages/payment/payment.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';
// import 'package:flutter_horizontal_date_picker/flutter_horizontal_date_picker.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/views/widgets/trip_widget.dart';
import 'package:bus_stop/views/widgets/custom_search/trip.dart';

class TripsView extends StatefulWidget {
  const TripsView({super.key});

  @override
  State<TripsView> createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView> {
  // DateTime selected0 = DateTime.now().to000000;
  //
  // bool use000000 = false;
  //
  // DateTime get _now => use000000 ? DateTime.now().to000000 : DateTime.now();
  //
  // Duration _kSampleDurationToEndDay = Duration(days: 10);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Trips",
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
      body: Column(
        children: [
          // Container(
          //   color: Color(0xffffffff),
          //   child: HorizontalDatePicker(
          //     needFocus: true,
          //     begin: _now,
          //     end: _now.add(_kSampleDurationToEndDay),
          //     selected: selected0,
          //     onSelected: (item) {
          //       setState(() {
          //         selected0 = item;
          //       });
          //     },
          //     selectedColor: Colors.transparent,
          //     unSelectedColor: Colors.transparent,
          //     itemBuilder: (DateTime itemValue, DateTime? selected) {
          //       var itemValueEdit =
          //       DateTime(itemValue.year, itemValue.month, itemValue.day);
          //       var selectedEdit =
          //       DateTime(selected!.year, selected.month, selected.day);
          //
          //       // print("itemValue : " + itemValueEdit.toString() + " " + "selected : " + selectedEdit.toString());
          //
          //       bool isSelected =
          //           itemValueEdit.toString() == selectedEdit.toString();
          //       // bool isSelected = selected?.difference(itemValue).inMilliseconds == 0;
          //
          //       return Container(
          //         width: 100,
          //         decoration: BoxDecoration(
          //           border: Border(
          //             bottom: BorderSide(
          //               width: 5,
          //               color: isSelected
          //                   ? Theme.of(context).primaryColor
          //                   : Colors.transparent,
          //             ),
          //           ),
          //         ),
          //         child: Center(
          //           child: Text(
          //             itemValue.toLocal().formatted(
          //                 pattern: isSelected ? "EEE dd/MM" : "EEE, dd/MM"),
          //             // Ensure you have 'toLocal()' if using DateTime UTC
          //             style: TextStyle(
          //                 color: isSelected ? Colors.black : Colors.black54,
          //                 fontSize: isSelected ? 14 : 10,
          //                 fontWeight: FontWeight.bold),
          //             textAlign: TextAlign.center,
          //           ),
          //         ),
          //       );
          //     },
          //     itemCount: 10,
          //     itemSpacing: 7,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(child: Container(
                  height: 50,
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      showSearch(
                          context: context,
                          delegate: CustomSearchTripWidget());
                    },
                    decoration: InputDecoration(
                      hintText: "Search Trip",
                      hintStyle: textTheme.bodyMedium!.copyWith(
                        fontSize: 15
                      ),
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                ))
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: fetchActiveTrips(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Something Went Wrong!",
                        style: textTheme.bodyMedium!.copyWith(
                            color: Colors.black, fontSize: 15),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: LoadingWidget());
                  }

                  List<Trip>? data = snapshot.data;

                  if (data == null) {
                    return const Center(child: LoadingWidget());
                  }

                  if(data.isEmpty) {
                    return Center(
                      child: Text(
                        "No Trips At The Moment!",
                        style: textTheme.bodyMedium!.copyWith(
                            color: Colors.black, fontSize: 15),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, int index) {
                          return GestureDetector(
                            onTap: () {
                              if(data[index].isClosed) {
                                return;
                              }
                              if (data[index].tripType == "Ordinary") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentView(
                                          trip: data[index],
                                          ticketChoice: "Ordinary",
                                          ticketChoicePrice: data[index].discountPriceOrdinary > 0 ? data[index].discountPriceOrdinary : data[index].priceOrdinary,
                                        )));
                              } else {
                                _openBottomSheet(context: context, trip:  data[index]);
                              }
                            },
                            child: TripWidget(trip: data[index]),
                          );
                        }),
                  );
                }
            ),
          )
        ],
      ),
      // bottomNavigationBar: buildBottomAppBar(context: context, activeBar: 1),
    );
  }

  void _openBottomSheet({required BuildContext context, required Trip trip}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getTicketOptions(context,trip);
        });
  }

  Widget _getTicketOptions(BuildContext context, Trip trip) {
    final options = [
      "Buy Ordinary Ticket",
      "Buy VIP Ticket",
    ];
    return Container(
      height: 150,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) => ListTile(
          onTap: () async {
            if (option == "Buy Ordinary Ticket") {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentView(
                        trip: trip,
                        ticketChoice: "Ordinary",
                        ticketChoicePrice:
                        trip.discountPriceOrdinary > 0
                            ? trip.discountPriceOrdinary
                            : trip.priceOrdinary,
                      )));
            }
            if (option == "Buy VIP Ticket") {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentView(
                        trip: trip,
                        ticketChoice: "VIP",
                        ticketChoicePrice:
                        trip.discountPriceVip > 0
                            ? trip.discountPriceVip
                            : trip.priceVip,
                      )));
            }
          },
          title: Column(
            children: [
              Text(
                option,
                textAlign: TextAlign.start,
                style: TextStyle(color: Color(0xFFE4191D)),
              ),
              SizedBox(height: 4),
              Divider(height: 1)
            ],
          ),
        ))
            .toList(),
      ),
    );
  }
}
