import 'package:bus_stop/models/busCompany.dart';
import 'package:bus_stop/models/destination/destination.dart';
import 'package:bus_stop/views/v3/main/widgets/custom_search/bus_company.dart';
import 'package:bus_stop/views/v3/main/widgets/custom_search/destination.dart';
import 'package:bus_stop/views/v3/pages/trips_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DraggableScrollableWidget extends StatefulWidget {
  final Function(bool) updateIsFrom;
  final TextEditingController fromCtr;
  final TextEditingController toCtr;
  final List<Destination> destinations;
  final Function(Destination) setPlace;
  final TextEditingController busCompanyCtr;
  final Function(BusCompany) setBusCompany;

  const DraggableScrollableWidget({
    super.key,
    required this.fromCtr,
    required this.toCtr,
    required this.updateIsFrom,
    required this.destinations,
    required this.setPlace,
    required this.busCompanyCtr,
    required this.setBusCompany,
  });

  @override
  State<DraggableScrollableWidget> createState() =>
      _DraggableScrollableWidgetState();
}

class _DraggableScrollableWidgetState extends State<DraggableScrollableWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _scrollPosition = 0.05;

  Destination? fromDest;
  Destination? toDest;

  final TextEditingController _busCompanyIdCtr = TextEditingController();

  _setFromDestination(Destination dest) {
    setState(() {
      fromDest = dest;
    });
  }

  _setToDestination(Destination dest) {
    setState(() {
      toDest = dest;
    });
  }

  _setBusCompanyId(String id) {
    setState(() {
      _busCompanyIdCtr.text = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        setState(() {
          _scrollPosition = notification.extent;
        });
        return true;
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.05,
        // initialChildSize: 0.7,
        // Height of the sheet as a fraction of the viewport height
        minChildSize: 0.05,
        maxChildSize: 0.7,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: _scrollPosition > 0.07 ? Color(0xffffffff) : Colors.white60,
              // color: Color(0xffffffff),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),

            // Builder should have a CustomScrollView widget to be able to scroll and drag the bottom sheet
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Icon(
                      _scrollPosition > 0.07
                          ? Icons.keyboard_arrow_down_outlined
                          : Icons.keyboard_arrow_up_outlined,
                      size: 35,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            const Text(
                              "Where would you like to go today?",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 40.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 50,
                                  height: 220,
                                  padding: EdgeInsets.only(top: 50, bottom: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                      Expanded(
                                          child: Container(
                                            color: Theme.of(context).primaryColor,
                                        width: 5,
                                      )),
                                      Container(
                                        width: 20,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 220,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("From"),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextFormField(
                                                  controller: widget.fromCtr,
                                                  readOnly: true,
                                                  onTap: () {
                                                    widget.updateIsFrom(true);
                                                    showSearch(
                                                        context: context,
                                                        delegate: CustomSearchDestinationWidget(
                                                            searchTerms: widget
                                                                .destinations,
                                                            setPlace:
                                                                widget.setPlace,
                                                            setDestination:
                                                                _setFromDestination));
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Select Departure",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      suffixIcon:
                                                          Icon(Icons.search)),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("To"),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextFormField(
                                                  controller: widget.toCtr,
                                                  readOnly: true,
                                                  onTap: () {
                                                    widget.updateIsFrom(false);
                                                    showSearch(
                                                        context: context,
                                                        delegate: CustomSearchDestinationWidget(
                                                            searchTerms: widget
                                                                .destinations,
                                                            setPlace:
                                                                widget.setPlace,
                                                            setDestination:
                                                                _setToDestination));
                                                  },
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Select Arrival",
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      suffixIcon:
                                                          Icon(Icons.search)),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 30.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Text("Agency/Bus Company"),
                                              SizedBox(width: 5,),
                                              Text(
                                                "*Optional",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Colors.blue[800],
                                                        fontSize: 14),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            controller: widget.busCompanyCtr,
                                            readOnly: true,
                                            onTap: () {
                                              showSearch(
                                                  context: context,
                                                  delegate:
                                                      CustomSearchBusCompanyWidget(
                                                          setBusCompany: widget
                                                              .setBusCompany,
                                                          setBusCompanyId:
                                                              _setBusCompanyId));
                                            },
                                            decoration: InputDecoration(
                                                hintText: "Select company",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                suffixIcon: const Icon(
                                                    Icons.keyboard_arrow_down)),
                                            validator: (value) {
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40.0),
                            Row(
                              children: [
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    bool formValid =
                                        _formKey.currentState!.validate();
                                    if (!formValid) {
                                      Fluttertoast.showToast(
                                          msg: "Fill in the required fields");
                                      return;
                                    }

                                    if (fromDest == null && toDest == null) {
                                      Fluttertoast.showToast(
                                          msg: "Select Departure & Arrival");
                                      return;
                                    }

                                    Get.to(() => TripsSearchView(
                                        fro: fromDest!,
                                        to: toDest!,
                                        busCompanyId: _busCompanyIdCtr.text));
                                  },
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "Book The Trip",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class DraggableScrollableWidget extends StatefulWidget {
//   final Function(bool) updateIsFrom;
//   final Function(bool) updateIsSearching;
//   final TextEditingController fromCtr;
//   final TextEditingController toCtr;
//
//   const DraggableScrollableWidget({
//     super.key,
//     required this.fromCtr,
//     required this.toCtr,
//     required this.updateIsFrom,
//     required this.updateIsSearching,
//   });
//
//   @override
//   State<DraggableScrollableWidget> createState() =>
//       _DraggableScrollableWidgetState();
// }
//
// class _DraggableScrollableWidgetState extends State<DraggableScrollableWidget> {
//   double _scrollPosition = 0.05;
//
//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener<DraggableScrollableNotification>(
//       onNotification: (notification) {
//         // print(notification.minExtent);
//         // print(notification.maxExtent);
//         // print(notification.extent);
//
//         setState(() {
//           _scrollPosition = notification.extent;
//         });
//         return true;
//       },
//       child: DraggableScrollableSheet(
//         initialChildSize: 0.05,
//         // Height of the sheet as a fraction of the viewport height
//         minChildSize: 0.05,
//         maxChildSize: 0.7,
//         builder: (BuildContext context, ScrollController scrollController) {
//           return Container(
//             clipBehavior: Clip.hardEdge,
//             decoration: BoxDecoration(
//               color: _scrollPosition > 0.07 ? Colors.white : Colors.white60,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(25),
//                 topRight: Radius.circular(25),
//               ),
//             ),
//
//             // Builder should have a CustomScrollView widget to be able to scroll and drag the bottom sheet
//             child: CustomScrollView(
//               controller: scrollController,
//               slivers: [
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 5),
//                     child: Icon(
//                       _scrollPosition > 0.07
//                           ? Icons.keyboard_arrow_down_outlined
//                           : Icons.keyboard_arrow_up_outlined,
//                       size: 35,
//                     ),
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Form(
//                       child: Container(
//                         width: double.infinity,
//                         child: Column(
//                           children: [
//                             const Text(
//                               "Where would you like to go today?",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 40.0),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: 50,
//                                   height: 200,
//                                   // color: Colors.green,
//                                   padding: EdgeInsets.only(top: 50, bottom: 20),
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         width: 20,
//                                         height: 30,
//                                         decoration: BoxDecoration(
//                                             color: Colors.red,
//                                             borderRadius:
//                                                 BorderRadius.circular(15)),
//                                       ),
//                                       Expanded(
//                                           child: Container(
//                                         color: Colors.red,
//                                         width: 5,
//                                       )),
//                                       Container(
//                                         width: 20,
//                                         height: 30,
//                                         decoration: BoxDecoration(
//                                             color: Colors.red,
//                                             borderRadius:
//                                                 BorderRadius.circular(15)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         height: 200,
//                                         // color: Colors.blue,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text("From"),
//                                                 SizedBox(
//                                                   height: 5,
//                                                 ),
//                                                 TextFormField(
//                                                   controller: widget.fromCtr,
//                                                   readOnly: true,
//                                                   onTap: () {
//                                                     widget.updateIsFrom(true);
//                                                     widget.updateIsSearching(
//                                                         true);
//                                                   },
//                                                   decoration: InputDecoration(
//                                                       border:
//                                                           OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           10)),
//                                                       suffixIcon:
//                                                           Icon(Icons.search)),
//                                                   validator: (value) {
//                                                     if (value == null ||
//                                                         value.isEmpty) {
//                                                       return 'From';
//                                                     }
//                                                     return null;
//                                                   },
//                                                 ),
//                                               ],
//                                             ),
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text("To"),
//                                                 SizedBox(
//                                                   height: 5,
//                                                 ),
//                                                 TextFormField(
//                                                   controller: widget.toCtr,
//                                                   readOnly: true,
//                                                   onTap: () {
//                                                     widget.updateIsFrom(false);
//                                                     widget.updateIsSearching(
//                                                         true);
//                                                   },
//                                                   decoration: InputDecoration(
//                                                       border:
//                                                           OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           10)),
//                                                       suffixIcon:
//                                                           Icon(Icons.search)),
//                                                   validator: (value) {
//                                                     if (value == null ||
//                                                         value.isEmpty) {
//                                                       return 'To';
//                                                     }
//                                                     return null;
//                                                   },
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: 30.0),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           const Text("Agency"),
//                                           const SizedBox(
//                                             height: 5,
//                                           ),
//                                           TextFormField(
//                                             // controller: _nameController,
//                                             readOnly: true,
//                                             decoration: InputDecoration(
//                                                 border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10)),
//                                                 suffixIcon: const Icon(
//                                                     Icons.keyboard_arrow_down)),
//                                             validator: (value) {
//                                               if (value == null ||
//                                                   value.isEmpty) {
//                                                 return 'Agency';
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 40.0),
//                             Row(
//                               children: [
//                                 Expanded(
//                                     child: GestureDetector(
//                                   onTap: () {
//                                     Get.to(() => TripsSearchView());
//                                   },
//                                   child: Container(
//                                     height: 50,
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                         color: Colors.red,
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Text(
//                                       "Book The Trip",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ))
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
