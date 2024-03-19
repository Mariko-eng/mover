import 'dart:async';

import 'package:bus_stop/models/parkLocation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusCompanyDestinationsMapView extends StatefulWidget {
  final ParkLocations data;

  const BusCompanyDestinationsMapView({Key? key, required this.data}) : super(key: key);

  @override
  _BusCompanyDestinationsMapViewState createState() =>
      _BusCompanyDestinationsMapViewState();
}

class _BusCompanyDestinationsMapViewState
    extends State<BusCompanyDestinationsMapView> {
  final Completer<GoogleMapController> _controller = Completer();

  late CameraPosition _kGooglePlex;

  late LatLng startLocation;

  @override
  void initState() {
    super.initState();
    setState(() {
      startLocation = LatLng(widget.data.positionLat, widget.data.positionLng);
      _kGooglePlex = CameraPosition(
        tilt: 30,
        target: LatLng(widget.data.positionLat, widget.data.positionLng),
        zoom: 15.4746,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfffdfdfd),
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
            widget.data.destinationName + ", " + widget.data.parkLocationName,
            style: TextStyle(color: Colors.red[900]),
          )),
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight * 1.0,
                width: constraints.maxWidth,
                color: Colors.grey[200],
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: GoogleMap(
                  mapType: MapType.normal,
                  indoorViewEnabled: true,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: <Marker>{
                    Marker(
                      markerId: MarkerId("destination"),
                      infoWindow: InfoWindow(title: "destination"),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                      position: startLocation,
                      // draggable: true,
                    ),
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
