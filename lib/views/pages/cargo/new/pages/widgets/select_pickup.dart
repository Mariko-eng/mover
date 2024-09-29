import 'package:bus_stop/config/google_maps/google_maps.dart';
import 'package:bus_stop/models/placesModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_maps_webservice/places.dart';

class SelectPickUpLocationView extends StatefulWidget {
  final Function setPickupLocation;
  const SelectPickUpLocationView({super.key, required this.setPickupLocation});

  @override
  State<SelectPickUpLocationView> createState() => _SelectPickUpLocationViewState();
}

class _SelectPickUpLocationViewState extends State<SelectPickUpLocationView> {
  GoogleMapController? mapController; //controller for Google map

  static const CameraPosition _kGooglePlex = CameraPosition(
    tilt: 30,
    target: LatLng(0.3476, 32.5825),
    zoom: 15.4746,
  );

  LatLng startLocation = LatLng(0.3476, 32.5825);

  TextEditingController controller = TextEditingController();

  String? locationId;
  String? locationName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Pickup Location"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    minLines: 1,
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        labelText: "Pick Up Location",
                        labelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    controller: controller,
                    readOnly: true,
                    onTap: () async {
                      Prediction? p1 = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleApiKey,
                          mode: Mode.overlay,
                          // Mode.fullscreen
                          components: [new Component(Component.country, "ug")]);
                      if (p1 != null) {
                        setState(() {
                          controller.text = p1.description!;
                        });
                        _getPickUpAddressCoordinates(
                            placeId: p1.placeId!, placeName: p1.description!);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                indoorViewEnabled: true,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (controller) {
                  //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
                markers: <Marker>{
                  Marker(
                    markerId: MarkerId("destination"),
                    infoWindow: InfoWindow(title: "destination"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen),
                    position: startLocation,
                  ),
                },
              )),
        ],
      ),
      bottomNavigationBar: locationId == null
          ? Container(
        height: 0,
      )
          : GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: const Text(
            "Select Coordinates",
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Future<void> _getPickUpAddressCoordinates(
      {required String placeId, required String placeName}) async {
    try {
      PlacesService _placeService = PlacesService();
      Place address = await _placeService.getPlace(placeId);

      LatLng cd =
      LatLng(address.geometry.location.lat, address.geometry.location.lng);
      setState(() {
        startLocation = cd;
        locationId = placeId;
        locationName = placeName;
      });
      widget.setPickupLocation(cd, locationId, locationName);
      _changeCameraPosition(cd);
    } catch (err) {
      print(err.toString());
    }
  }

  _changeCameraPosition(LatLng latLng) {
    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLng(latLng));
    }
  }
}
