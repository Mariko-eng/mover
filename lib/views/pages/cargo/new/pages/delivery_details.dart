import 'package:bus_stop/views/pages/cargo/new/pages/widgets/select_pickup.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/busCompany.dart';
import 'package:bus_stop/models/destination/destination.dart';
import 'package:bus_stop/views/pages/cargo/new/pages/widgets/select_company.dart';
import 'package:bus_stop/views/pages/cargo/new/pages/widgets/select_destinations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewCargoDeliveryDetails extends StatefulWidget {
  final TextEditingController busCompanyIdCtr;
  final TextEditingController busCompanyNameCtr;
  final TextEditingController departureIdCtr;
  final TextEditingController departureNameCtr;
  final TextEditingController arrivalIdCtr;
  final TextEditingController arrivalNameCtr;
  final TextEditingController dateTimeCtr;
  final TextEditingController pickUpIdCtr;
  final TextEditingController pickUpNameCtr;
  final TextEditingController pickUpLatCtr;
  final TextEditingController pickUpLngCtr;
  final GlobalKey<FormState> formKey;

  const NewCargoDeliveryDetails(
      {super.key,
      required this.formKey,
      required this.busCompanyIdCtr,
      required this.busCompanyNameCtr,
      required this.departureIdCtr,
      required this.departureNameCtr,
      required this.arrivalIdCtr,
      required this.arrivalNameCtr,
      required this.dateTimeCtr,
      required this.pickUpIdCtr,
      required this.pickUpNameCtr,
      required this.pickUpLatCtr,
      required this.pickUpLngCtr});

  @override
  State<NewCargoDeliveryDetails> createState() =>
      _NewCargoDeliveryDetailsState();
}

class _NewCargoDeliveryDetailsState extends State<NewCargoDeliveryDetails> {

  _setPickupLocation(LatLng value, placeId, placeName) {
    setState(() {
      widget.pickUpIdCtr.text = placeId;
      widget.pickUpNameCtr.text = placeName;
      widget.pickUpLatCtr.text = value.latitude.toString();
      widget.pickUpLngCtr.text = value.longitude.toString();
    });
  }

  _setBusCompany(BusCompany company) {
    setState(() {
      widget.busCompanyIdCtr.text = company.uid;
      widget.busCompanyNameCtr.text = company.name;
    });
  }

  _setDepartureDestination(Destination dest) {
    setState(() {
      widget.departureIdCtr.text = dest.id;
      widget.departureNameCtr.text = dest.name;
    });
  }

  _setArrivalDestination(Destination dest) {
    setState(() {
      widget.arrivalIdCtr.text = dest.id;
      widget.arrivalNameCtr.text = dest.name;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery Info",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Bus Company"),
                      Text(
                        "*Optional",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 15, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: widget.busCompanyNameCtr,
                          onTap: () {
                            showGeneralDialog(
                                context: context,
                                barrierDismissible: false,
                                // should dialog be dismissed when tapped outside
                                barrierLabel: "Modal",
                                // label for barrier
                                transitionDuration: Duration(milliseconds: 500),
                                // how long it takes to popup dialog after button click
                                pageBuilder: (_, __, ___) {
                                  return SelectBusCompanyView(
                                      selectBusCompany: _setBusCompany);
                                });
                          },
                          decoration: InputDecoration(
                              hintText: "Select Bus Company",
                              border: OutlineInputBorder(),
                              suffixIcon:
                                  Icon(Icons.arrow_drop_down_circle_outlined)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select company';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FROM?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: widget.departureNameCtr,
                          onTap: () {
                            showGeneralDialog(
                                context: context,
                                barrierDismissible: false,
                                // should dialog be dismissed when tapped outside
                                barrierLabel: "Modal",
                                // label for barrier
                                transitionDuration: Duration(milliseconds: 500),
                                // how long it takes to popup dialog after button click
                                pageBuilder: (_, __, ___) {
                                  return SelectDestinationsView(
                                    selectDestination: _setDepartureDestination,
                                  );
                                });
                          },
                          decoration: InputDecoration(
                              hintText: "Select Departure Location",
                              border: OutlineInputBorder(),
                              suffixIcon:
                                  Icon(Icons.arrow_drop_down_circle_outlined)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select departure';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TO?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: widget.arrivalNameCtr,
                          onTap: () {
                            showGeneralDialog(
                                context: context,
                                barrierDismissible: false,
                                // should dialog be dismissed when tapped outside
                                barrierLabel: "Modal",
                                // label for barrier
                                transitionDuration: Duration(milliseconds: 500),
                                // how long it takes to popup dialog after button click
                                pageBuilder: (_, __, ___) {
                                  return SelectDestinationsView(
                                    selectDestination: _setArrivalDestination,
                                  );
                                });
                          },
                          decoration: InputDecoration(
                              hintText: "Select Arrival Location",
                              border: OutlineInputBorder(),
                              suffixIcon:
                                  Icon(Icons.arrow_drop_down_circle_outlined)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select arrival';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date/Time",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.dateTimeCtr,
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: "ASAP",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select date/time';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Additional Pickup Location ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        "*Optional",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 15, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: widget.pickUpNameCtr,
                          onTap: () {
                            showGeneralDialog(
                                context: context,
                                barrierDismissible: false,
                                // should dialog be dismissed when tapped outside
                                barrierLabel: "Modal",
                                // label for barrier
                                transitionDuration: Duration(milliseconds: 500),
                                // how long it takes to popup dialog after button click
                                pageBuilder: (_, __, ___) {
                                  return SelectPickUpLocationView(
                                    setPickupLocation: _setPickupLocation,);
                                });
                          },
                          decoration: InputDecoration(
                              hintText: "Select Package's Exact Location",
                              border: OutlineInputBorder(),
                              suffixIcon:
                                  Icon(Icons.arrow_drop_down_circle_outlined)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      "Home / Work / Office / Your Package's Exact Location At An Extra Cost",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15, color: Colors.grey[700])),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
