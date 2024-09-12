import 'package:bus_stop/views/v3/main/widgets/draggable_scrollable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bus_stop/services/directions_service.dart';
import 'package:bus_stop/models/destination/destination.dart';
import 'package:bus_stop/models/directions_model.dart';
import 'package:bus_stop/contollers/locController.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final DraggableScrollableController _draggableScrollableController = DraggableScrollableController();
  LocationController locationController = Get.find();

  // created controller for displaying Google Maps
  final Completer<GoogleMapController> _googleMapController = Completer();

  // given camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(0.3152, 32.5816),
    zoom: 10.5,
    tilt: 40.0,
  );

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

  final TextEditingController _fromCtr = TextEditingController();
  final TextEditingController _toCtr = TextEditingController();
  final TextEditingController _searchCtr = TextEditingController();

  Destination? _fromDestination;
  Destination? _toDestination;

  double? totalDistanceValue;
  String? totalDuration;
  Set<Polyline>? polys;
  LatLngBounds? bounds;

  bool isFrom = true;
  bool _isSearching = false;

  List<Destination> _items = [];
  List<Destination> _selItems = [];

  _getDestinations() async {
    try {
      await locationController.getDestinations();

      setState(() {
        _items = locationController.destinations;
        _loadMarkers(_items);
      });
    } catch (e) {
      print("Failed to fetch destinations: $e");
    }
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
      }
      setState(() {});
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
    super.initState();
    _getDestinations();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateIsFrom (bool val) {
    setState(() {
      isFrom = val;
    });
  }

  void _updateIsSearching (bool val) {
    setState(() {
      _isSearching = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        children: [
          Stack(
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
                    _googleMapController.complete(controller);
                  },
                  polylines: polys == null ? {} : polys!,
                ),
              ),

              DraggableScrollableWidget(
                fromCtr: _fromCtr,
                toCtr: _toCtr,
                updateIsFrom: _updateIsFrom,
                updateIsSearching: _updateIsSearching,
              ),
            ],
          ),
          Visibility(
              visible: _isSearching,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: statusBarHeight + 20, left: 10, right: 10),
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
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (String val) {
                              List<Destination> results = [];
                              if (val.trim().isNotEmpty) {
                                for (int i = 0; i < _items.length; i++) {
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
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSearching = false;
                              _selItems = [];
                            });
                          },
                          child: ListView(
                            children: _searchCtr.text.isEmpty
                                ? [
                                    ..._items
                                        .map((item) => GestureDetector(
                                              onTap: () {
                                                _setPlace(item);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      item.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ))
                                        .toList()
                                  ]
                                : [
                                    ..._selItems
                                        .map((item) => GestureDetector(
                                              onTap: () {
                                                _setPlace(item);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      item.name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ))
                                        .toList()
                                  ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
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
    GoogleMapController controller = await _googleMapController.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }
}

// Builder should have a CustomScrollView widget to be able to scroll and drag the bottom sheet
// child: CustomScrollView(
//   controller: scrollController,
//   slivers: [
//
//     // SliverToBoxAdapter(
//     //   child: Icon(
//     //         (dragController.size > 0.05
//     //         ? Icons.arrow_upward
//     //         : Icons.arrow_downward)
//     //   ),
//     // ),
//
//     SliverToBoxAdapter(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           child: Container(
//             width: double.infinity,
//             child: Column(
//               children: [
//                 const Text(
//                   "Where would you like to go today?",
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 40.0),
//                 Row(
//                   crossAxisAlignment:
//                       CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 50,
//                       height: 200,
//                       // color: Colors.green,
//                       padding: EdgeInsets.only(
//                           top: 50, bottom: 20),
//                       child: Column(
//                         mainAxisAlignment:
//                             MainAxisAlignment
//                                 .spaceBetween,
//                         children: [
//                           Container(
//                             width: 20,
//                             height: 30,
//                             decoration: BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius:
//                                     BorderRadius
//                                         .circular(
//                                             15)),
//                           ),
//                           Expanded(
//                               child: Container(
//                             color: Colors.red,
//                             width: 5,
//                           )),
//                           Container(
//                             width: 20,
//                             height: 30,
//                             decoration: BoxDecoration(
//                                 color: Colors.red,
//                                 borderRadius:
//                                     BorderRadius
//                                         .circular(
//                                             15)),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 200,
//                             // color: Colors.blue,
//                             child: Column(
//                               mainAxisAlignment:
//                                   MainAxisAlignment
//                                       .spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment
//                                           .start,
//                                   children: [
//                                     Text("From"),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     TextFormField(
//                                       controller:
//                                           _fromCtr,
//                                       readOnly: true,
//                                       onTap: () {
//                                         setState(() {
//                                           isFrom =
//                                               true;
//                                           _isSearching =
//                                               true;
//                                         });
//                                       },
//                                       decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       10)),
//                                           suffixIcon:
//                                               Icon(Icons
//                                                   .search)),
//                                       validator:
//                                           (value) {
//                                         if (value ==
//                                                 null ||
//                                             value
//                                                 .isEmpty) {
//                                           return 'From';
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment
//                                           .start,
//                                   children: [
//                                     Text("To"),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     TextFormField(
//                                       controller:
//                                           _toCtr,
//                                       readOnly: true,
//                                       onTap: () {
//                                         setState(() {
//                                           isFrom =
//                                               false;
//                                           _isSearching =
//                                               true;
//                                         });
//                                       },
//                                       decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       10)),
//                                           suffixIcon:
//                                               Icon(Icons
//                                                   .search)),
//                                       validator:
//                                           (value) {
//                                         if (value ==
//                                                 null ||
//                                             value
//                                                 .isEmpty) {
//                                           return 'To';
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 30.0),
//                           Column(
//                             crossAxisAlignment:
//                                 CrossAxisAlignment
//                                     .start,
//                             children: [
//                               const Text("Agency"),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               TextFormField(
//                                 // controller: _nameController,
//                                 readOnly: true,
//                                 decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius
//                                                 .circular(
//                                                     10)),
//                                     suffixIcon: const Icon(Icons
//                                         .keyboard_arrow_down)),
//                                 validator: (value) {
//                                   if (value == null ||
//                                       value.isEmpty) {
//                                     return 'Agency';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 40.0),
//                 Container(
//                   width: double.infinity,
//                   child: Row(
//                     children: [
//                       Expanded(
//                           child: Container(
//                         height: 50,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius:
//                                 BorderRadius.circular(
//                                     10)),
//                         child: Text(
//                           "Book The Trip",
//                           style: TextStyle(
//                               color: Colors.white),
//                         ),
//                       ))
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//
//     // SliverList.list(children: const [
//     //   ListTile(title: Text('Jane Doe')),
//     //   ListTile(title: Text('Jack reacher')),
//     // ])
//   ],
// ),