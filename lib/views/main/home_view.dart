import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/contollers/authController.dart';
import 'package:bus_stop/views/pages/settings/SettingsView.dart';
import 'package:bus_stop/contollers/lcoProvider.dart';
import 'package:bus_stop/models/destination/destination.dart';
import 'package:bus_stop/models/directions_model.dart';
import 'package:bus_stop/services/directions_service.dart';
import 'package:bus_stop/views/widgets/bottom_bar_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bus_stop/views/pages/trips/search_destination_list.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // created controller for displaying Google Maps
  Completer<GoogleMapController> _controller = Completer();

  // given camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(0.3152, 32.5816),
    zoom: 7,
  );

  Uint8List? marketimages;
  List<Marker> _markers = <Marker>[];

  // declared method to get Images
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  bool _isSearching = false;

  List<Destination> _selItems = [];
  double? totalDistanceValue;
  String? totalDuration;
  Set<Polyline>? polys;
  LatLngBounds? bounds;

  Destination? _fromDestination;
  Destination? _toDestination;

  final TextEditingController _searchCtr = TextEditingController();

  final _fromCtr = TextEditingController();
  final _toCtr = TextEditingController();

  bool isFrom = true;
  bool showMenu = false;

  late LocationsProvider locationsProvider;
  List<Destination> _items = [];

  _getDestinations() async {
    locationsProvider = Provider.of<LocationsProvider>(context, listen: false);

    setState(() {
      _items = locationsProvider.destinations;
      _loadMarkers(_items);
    });
  }

  _loadMarkers(List<Destination> destinations) async {
    if (destinations.isNotEmpty) {
      for (int i = 0; i < destinations.length; i++) {
        String busImage = 'assets/images/bus.png';

        final Uint8List markIcons = await getImages(busImage, 100);
        // makers added according to index
        _markers.add(Marker(
          // given marker id
          markerId: MarkerId(i.toString()),
          // given marker icon
          icon: BitmapDescriptor.fromBytes(markIcons),
          // given position
          position: LatLng(
              destinations[i].locationDetails!.geometry!.location.lat,
              destinations[i].locationDetails!.geometry!.location.lng),
          infoWindow: InfoWindow(
            // given title for marker
            title: 'Location: ' + destinations[i].name,
          ),
        ));
        setState(() {});
      }
    }
  }

  _setPlace(Destination destination) {
    setState(() {
      if (isFrom) {
        if (_toCtr.text != destination.name) {
          _fromDestination = destination;
          _fromCtr.text = destination.name;
        }
      } else {
        if (_fromCtr.text != destination.name) {
          _toDestination = destination;
          _toCtr.text = destination.name;
        }
      }
      _isSearching = false;

      if (_fromDestination != null && _toDestination != null) {
        LatLng? org =
            _fromDestination!.locationDetails?.geometry?.location != null
                ? LatLng(
                    _fromDestination!.locationDetails!.geometry!.location.lat,
                    _fromDestination!.locationDetails!.geometry!.location.lng)
                : null;
        LatLng? dest =
            _toDestination!.locationDetails?.geometry?.location != null
                ? LatLng(
                    _toDestination!.locationDetails!.geometry!.location.lat,
                    _toDestination!.locationDetails!.geometry!.location.lng)
                : null;

        _markers = <Marker>[];

        if (org != null && dest != null) {
          _getDirectionsData(org, dest);
          _loadMarkers([_fromDestination!, _toDestination!]);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getDestinations();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: GoogleMap(
                            // given camera position
                            initialCameraPosition: _kGoogle,
                            // set markers on google map
                            markers: Set<Marker>.of(_markers),
                            // on below line we have given map type
                            mapType: MapType.normal,
                            // on below line we have enabled location
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            // on below line we have enabled compass
                            compassEnabled: true,
                            zoomControlsEnabled: false,
                            // below line displays google map in our app
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            polylines: polys == null ? {} : polys!,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 300,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                                width: 40,
                                                height: 40,
                                                child: const Icon(
                                                    Icons.location_history)),
                                            Container(
                                              width: 5,
                                              height: 70,
                                              color: Color(0xffE4181D),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Text("From"),
                                                  // Icon(Icons.arrow_drop_down)
                                                ],
                                              ),
                                              Container(
                                                width: double.infinity,
                                                // height: 50,
                                                child: TextField(
                                                  controller: _fromCtr,
                                                  readOnly: true,
                                                  onTap: () {
                                                    setState(() {
                                                      isFrom = true;
                                                      _isSearching = true;
                                                    });
                                                  },
                                                  textAlignVertical:
                                                      TextAlignVertical.bottom,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      labelText: "Source",
                                                      labelStyle: TextStyle(
                                                          fontSize: 15),
                                                      suffixIcon:
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  isFrom = true;
                                                                  _isSearching =
                                                                      true;
                                                                });
                                                              },
                                                              child: Icon(Icons
                                                                  .search))),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                                width: 40,
                                                height: 40,
                                                child: const Icon(
                                                    Icons.location_on)),
                                            Container(
                                              width: 5,
                                              height: 50,
                                              color: Color(0xffE4181D),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("To"),
                                                  // Icon(Icons.arrow_drop_down)
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                height: 50,
                                                child: TextField(
                                                  controller: _toCtr,
                                                  readOnly: true,
                                                  onTap: () {
                                                    setState(() {
                                                      isFrom = false;
                                                      _isSearching = true;
                                                    });
                                                  },
                                                  textAlignVertical:
                                                      TextAlignVertical.bottom,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      labelText: "Destination",
                                                      labelStyle: TextStyle(
                                                          fontSize: 15),
                                                      suffixIcon:
                                                          GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  isFrom =
                                                                      false;
                                                                  _isSearching =
                                                                      true;
                                                                });
                                                              },
                                                              child: Icon(Icons
                                                                  .search))),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_fromDestination == null) {
                                        Get.snackbar("Failed",
                                            "Please Select Your Departure Destination",
                                            backgroundColor: Colors.orange,
                                            colorText: Colors.white);
                                        return;
                                      }
                                      if (_toDestination == null) {
                                        Get.snackbar("Failed",
                                            "Please Select Your Arrival Destination",
                                            backgroundColor: Colors.orange,
                                            colorText: Colors.white);
                                        return;
                                      }
                                      if (_fromDestination!.id ==
                                          _toDestination!.id) {
                                        Get.snackbar("Failed",
                                            "Destinations Must Be Different!",
                                            backgroundColor: Colors.orange,
                                            colorText: Colors.white);
                                        return;
                                      } else {
                                        Get.to(() => SearchDestinationListView(
                                            fro: _fromDestination!,
                                            to: _toDestination!));
                                      }
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffE4181D),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Text(
                                          "SEARCH TRIP".toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.white),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: _isSearching,
                            child: Container(
                              color: Colors.black.withOpacity(0.7),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: TextField(
                                          controller: _searchCtr,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            suffixIcon: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _isSearching = false;
                                                    _selItems = [];
                                                  });
                                                },
                                                child: Icon(Icons.close)),
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: 'Search...',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          onChanged: (String val) {
                                            List<Destination> results = [];
                                            if (val.trim().isNotEmpty) {
                                              for (int i = 0;
                                                  i < _items.length;
                                                  i++) {
                                                if (_items[i]
                                                    .name
                                                    .toLowerCase()
                                                    .contains(val)) {
                                                  results.add(_items[i]);
                                                }
                                              }
                                            }

                                            setState(() {
                                              _selItems = results;
                                            });
                                          },
                                        ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: _searchCtr.text.isEmpty
                                            ? [
                                                ..._items
                                                    .map(
                                                        (item) =>
                                                            GestureDetector(
                                                              onTap: () {
                                                                _setPlace(item);
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .location_on,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      item.name,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                              fontSize: 18,
                                                                              color: Colors.white),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ))
                                                    .toList()
                                              ]
                                            : [
                                                ..._selItems
                                                    .map(
                                                        (item) =>
                                                            GestureDetector(
                                                              onTap: () {
                                                                _setPlace(item);
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .location_on,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      item.name,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                              fontSize: 18,
                                                                              color: Colors.white),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ))
                                                    .toList()
                                              ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Visibility(
                          visible: !_isSearching,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                !showMenu
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showMenu = true;
                                          });
                                        },
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                  'assets/images/image1.png'),
                                              const Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Icon(
                                                      Icons.menu,
                                                      color: Colors.white,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 200,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 2),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  child: const Icon(
                                                    Icons.settings,
                                                    color: Color(0xffffffff),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      // color: Color(0xffE4181D),
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(
                                                        () => SettingsView());
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 110,
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      "My Account",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red[900],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: 200,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 2),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  child: const Icon(
                                                    Icons.logout,
                                                    color: Color(0xffffffff),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      // color: Color(0xffE4181D),
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                ),
                                                GestureDetector(
                                                  onDoubleTap: () {
                                                    userProvider.signOut();
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 110,
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      "Logout",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.red[900],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 70,
                                            width: 200,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 2),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      showMenu = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 70,
                                                    width: 70,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          child: Image.asset(
                                                              'assets/images/stop.png'),
                                                        ),
                                                        const Align(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: Icon(
                                                                Icons
                                                                    .cancel_outlined,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomAppBar(context: context, activeBar: 0),
    );
  }

  _getDirectionsData(LatLng origin, LatLng destination) async {
    DirectionsService _ds = DirectionsService();

    Directions? _data =
        await _ds.getDirections(origin: origin, destination: destination);

    if (_data != null) {
      setState(() {
        // _directions = _data;
        // totalDistanceValue = _data.totalDistanceValue;
        // totalDuration = _data.totalDuration;
        bounds = _data.bounds;
        polys = {
          Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Colors.red,
            width: 5,
            points: _data.polylinePoints
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          )
        };
        _changeCameraPosition(_data.bounds);
      });
    }
  }

  _changeCameraPosition(LatLngBounds bounds) async {
    // Animate the camera to fit the bounds
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }
}
