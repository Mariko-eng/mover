import 'package:bus_stop/models/busCompany.dart';
import 'package:bus_stop/models/destination/destination.dart';
import 'package:bus_stop/views/widgets/custom_search/bus_company.dart';
import 'package:bus_stop/views/widgets/custom_search/destination.dart';
import 'package:bus_stop/views/pages/trips_search.dart';
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
  double _scrollPosition = 0.75;

  Destination? fromDest;
  Destination? toDest;

  final TextEditingController _busCompanyIdCtr = TextEditingController();

  _setFromDestination(Destination dest) {
    setState(() {
      if (dest.id == "") {
        fromDest = null;
      }
      fromDest = dest;
    });
  }

  _setToDestination(Destination dest) {
    setState(() {
      if (dest.id == "") {
        toDest = null;
      }
      toDest = dest;
    });
  }

  _setBusCompanyId(String id) {
    setState(() {
      if (id == "") {
        _busCompanyIdCtr.clear();
      }
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
        // initialChildSize: 0.05,
        initialChildSize: 0.7,
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
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Where would you like to go today?",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 340,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 340 - 20,
                                      width: 40,
                                      padding: EdgeInsets.only(top: 40,bottom: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius:
                                                  BorderRadius.circular(10))
                                          ),
                                          Expanded(
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                // Calculate the number of items based on the width of the parent widget.
                                                final itemCount = (constraints.maxWidth / 7).floor();
                                                return Flex(
                                                  children: List.generate(
                                                    itemCount,
                                                        (index) => SizedBox(
                                                      height: 5,
                                                      width: 3,
                                                      child: DecoratedBox(
                                                        decoration:
                                                        BoxDecoration(color: Theme.of(context).primaryColor),
                                                      ),
                                                    ),
                                                  ),
                                                  direction: Axis.vertical,
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius:
                                                  BorderRadius.circular(10))
                                          ),
                                          Expanded(
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                // Calculate the number of items based on the width of the parent widget.
                                                final itemCount = (constraints.maxWidth / 7).floor();
                                                return Flex(
                                                  children: List.generate(
                                                    itemCount,
                                                        (index) => SizedBox(
                                                      height: 5,
                                                      width: 3,
                                                      child: DecoratedBox(
                                                        decoration:
                                                        BoxDecoration(
                                                            color: Theme.of(context).primaryColor.withOpacity(0.3)
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  direction: Axis.vertical,
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                );
                                              },
                                            ),
                                          ),
                                          Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor.withOpacity(0.3) ,
                                                  borderRadius:
                                                  BorderRadius.circular(10))
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: Container(
                                        height: 340 - 20,
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                      suffixIcon:
                                                      Icon(Icons.search)
                                                  ),
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
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
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
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                SizedBox(
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
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
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
                                      height: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Text(
                                        "Search Trip",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                ),


                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Form(
                //       key: _formKey,
                //       child: Container(
                //         width: double.infinity,
                //         child: Column(
                //           children: [
                //             const Text(
                //               "Where would you like to go today?",
                //               style: TextStyle(
                //                   fontSize: 18, fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(height: 40.0),
                //             Row(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Container(
                //                   width: 50,
                //                   height: 220,
                //                   padding: EdgeInsets.only(top: 50, bottom: 20),
                //                   child: Column(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Container(
                //                         width: 20,
                //                         height: 20,
                //                         decoration: BoxDecoration(
                //                             color: Theme.of(context).primaryColor,
                //                             borderRadius:
                //                                 BorderRadius.circular(7)),
                //                       ),
                //                       Expanded(
                //                         child: LayoutBuilder(
                //                           builder: (context, constraints) {
                //                             // Calculate the number of items based on the width of the parent widget.
                //                             final itemCount = (constraints.maxWidth / 7).floor();
                //                             return Flex(
                //                               children: List.generate(
                //                                 itemCount,
                //                                     (index) => SizedBox(
                //                                   height: 5,
                //                                   width: 3,
                //                                   child: DecoratedBox(
                //                                     decoration:
                //                                     BoxDecoration(color: Theme.of(context).primaryColor),
                //                                   ),
                //                                 ),
                //                               ),
                //                               direction: Axis.vertical,
                //                               mainAxisSize: MainAxisSize.max,
                //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                             );
                //                           },
                //                         ),
                //                       ),
                //                       // Expanded(
                //                       //     child: Container(
                //                       //       color: Theme.of(context).primaryColor,
                //                       //   width: 5,
                //                       // )),
                //                       Container(
                //                         width: 20,
                //                         height: 20,
                //                         decoration: BoxDecoration(
                //                             color: Theme.of(context).primaryColor,
                //                             borderRadius:
                //                                 BorderRadius.circular(10)),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //                 Expanded(
                //                   child: Column(
                //                     children: [
                //                       Container(
                //                         height: 220,
                //                         child: Column(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Column(
                //                               crossAxisAlignment:
                //                                   CrossAxisAlignment.start,
                //                               children: [
                //                                 Text("From"),
                //                                 SizedBox(
                //                                   height: 5,
                //                                 ),
                //                                 TextFormField(
                //                                   controller: widget.fromCtr,
                //                                   readOnly: true,
                //                                   onTap: () {
                //                                     widget.updateIsFrom(true);
                //                                     showSearch(
                //                                         context: context,
                //                                         delegate: CustomSearchDestinationWidget(
                //                                             searchTerms: widget
                //                                                 .destinations,
                //                                             setPlace:
                //                                                 widget.setPlace,
                //                                             setDestination:
                //                                                 _setFromDestination));
                //                                   },
                //                                   decoration: InputDecoration(
                //                                       hintText:
                //                                           "Select Departure",
                //                                       border:
                //                                           OutlineInputBorder(
                //                                               borderRadius:
                //                                                   BorderRadius
                //                                                       .circular(
                //                                                           10)),
                //                                       suffixIcon:
                //                                           Icon(Icons.search)
                //                                   ),
                //                                   validator: (value) {
                //                                     if (value == null ||
                //                                         value.isEmpty) {
                //                                       return 'Required';
                //                                     }
                //                                     return null;
                //                                   },
                //                                 ),
                //                               ],
                //                             ),
                //                             Column(
                //                               crossAxisAlignment:
                //                                   CrossAxisAlignment.start,
                //                               children: [
                //                                 Text("To"),
                //                                 SizedBox(
                //                                   height: 5,
                //                                 ),
                //                                 TextFormField(
                //                                   controller: widget.toCtr,
                //                                   readOnly: true,
                //                                   onTap: () {
                //                                     widget.updateIsFrom(false);
                //                                     showSearch(
                //                                         context: context,
                //                                         delegate: CustomSearchDestinationWidget(
                //                                             searchTerms: widget
                //                                                 .destinations,
                //                                             setPlace:
                //                                                 widget.setPlace,
                //                                             setDestination:
                //                                                 _setToDestination));
                //                                   },
                //                                   decoration: InputDecoration(
                //                                       hintText:
                //                                           "Select Arrival",
                //                                       border:
                //                                           OutlineInputBorder(
                //                                               borderRadius:
                //                                                   BorderRadius
                //                                                       .circular(
                //                                                           10)),
                //                                       suffixIcon:
                //                                           Icon(Icons.search)),
                //                                   validator: (value) {
                //                                     if (value == null ||
                //                                         value.isEmpty) {
                //                                       return 'Required';
                //                                     }
                //                                     return null;
                //                                   },
                //                                 ),
                //                               ],
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                       SizedBox(height: 30.0),
                //                       Column(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           Row(
                //                             mainAxisAlignment:
                //                                 MainAxisAlignment.start,
                //                             children: [
                //                               const Text("Agency/Bus Company"),
                //                               SizedBox(width: 5,),
                //                               Text(
                //                                 "*Optional",
                //                                 style: Theme.of(context)
                //                                     .textTheme
                //                                     .bodyMedium!
                //                                     .copyWith(
                //                                         color: Colors.blue[800],
                //                                         fontSize: 14),
                //                               ),
                //                             ],
                //                           ),
                //                           const SizedBox(
                //                             height: 5,
                //                           ),
                //                           TextFormField(
                //                             controller: widget.busCompanyCtr,
                //                             readOnly: true,
                //                             onTap: () {
                //                               showSearch(
                //                                   context: context,
                //                                   delegate:
                //                                       CustomSearchBusCompanyWidget(
                //                                           setBusCompany: widget
                //                                               .setBusCompany,
                //                                           setBusCompanyId:
                //                                               _setBusCompanyId));
                //                             },
                //                             decoration: InputDecoration(
                //                                 hintText: "Select company",
                //                                 border: OutlineInputBorder(
                //                                     borderRadius:
                //                                         BorderRadius.circular(
                //                                             10)),
                //                                 suffixIcon: const Icon(
                //                                     Icons.keyboard_arrow_down)),
                //                             validator: (value) {
                //                               return null;
                //                             },
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             SizedBox(height: 20.0),
                //             Row(
                //               children: [
                //                 Expanded(
                //                     child: GestureDetector(
                //                   onTap: () {
                //                     bool formValid =
                //                         _formKey.currentState!.validate();
                //                     if (!formValid) {
                //                       Fluttertoast.showToast(
                //                           msg: "Fill in the required fields");
                //                       return;
                //                     }
                //
                //                     if (fromDest == null && toDest == null) {
                //                       Fluttertoast.showToast(
                //                           msg: "Select Departure & Arrival");
                //                       return;
                //                     }
                //
                //                     Get.to(() => TripsSearchView(
                //                         fro: fromDest!,
                //                         to: toDest!,
                //                         busCompanyId: _busCompanyIdCtr.text));
                //                   },
                //                   child: Container(
                //                     height: 50,
                //                     alignment: Alignment.center,
                //                     decoration: BoxDecoration(
                //                         color: Theme.of(context).primaryColor,
                //                         borderRadius:
                //                             BorderRadius.circular(10)),
                //                     child: Text(
                //                       "Book The Trip",
                //                       style: TextStyle(color: Colors.white),
                //                     ),
                //                   ),
                //                 ))
                //               ],
                //             ),
                //             SizedBox(height: 20.0),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

              ],
            ),
          );
        },
      ),
    );
  }
}
