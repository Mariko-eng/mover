import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  // created controller for displaying Google Maps
  Completer<GoogleMapController> _controller = Completer();

  // given camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(0.3152, 32.5816),
    zoom: 7,
  );

  Uint8List? marketimages;
  List<String> images = [
    'assets/images/car.png',
    'assets/images/bus.png',
    'assets/images/car.png',
    'assets/images/bus.png',
    'assets/images/bike.png',
  ];

  // created empty list of markers
  final List<Marker> _markers = <Marker>[];

  // created list of coordinates of various locations
  final List<LatLng> _latLen = <LatLng>[
    LatLng(0.3152, 32.5816), // Kampala,
    LatLng(0.6072, 30.6545), // Mbarara
    LatLng(2.7724, 32.2881), // Gulu
    LatLng(0.1699, 30.0781), // Kasese
    LatLng(0.4479, 33.2026), // Jinja
    LatLng(3.0303, 30.9073), // Arrua,
  ];

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initialize loadData method
    loadData();
  }

  // created method for displaying custom markers according to index
  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markIcons = await getImages(images[i], 100);
      // makers added according to index
      _markers.add(Marker(
        // given marker id
        markerId: MarkerId(i.toString()),
        // given marker icon
        icon: BitmapDescriptor.fromBytes(markIcons),
        // given position
        position: _latLen[i],
        infoWindow: InfoWindow(
          // given title for marker
          title: 'Location: ' + i.toString(),
        ),
      ));
      setState(() {});
    }
  }

  bool _isSearching = false;

  final List<String> _items = [
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Ten",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Ten",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Ten"
  ];

  List<String> _selItems = [];

  final TextEditingController _searchCtr = TextEditingController();

  final _fromCtr = TextEditingController();
  final _toCtr = TextEditingController();

  bool isFrom = true;

  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Your App'),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(_isSearching ? Icons.close : Icons.search),
      //       onPressed: () {
      //         setState(() {
      //           _isSearching = !_isSearching;
      //         });
      //       },
      //     ),
      //   ],
      // ),
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
                                                  textAlignVertical: TextAlignVertical.bottom,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      labelText: "Source",
                                                      labelStyle: TextStyle(
                                                          fontSize: 15),
                                                    suffixIcon: Icon(Icons.search)
                                                  ),
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
                                                  textAlignVertical: TextAlignVertical.bottom,
                                                  decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10,
                                                              vertical: 5),
                                                      labelText: "Destination",
                                                      labelStyle: TextStyle(
                                                          fontSize: 15),
                                                      suffixIcon: Icon(Icons.search)
                                                  ),
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
                                    // onTap: () {
                                    //   if (_fromDestination == null) {
                                    //     Get.snackbar("Failed",
                                    //         "Please Select Your Departure Destination",
                                    //         backgroundColor: Colors.orange,
                                    //         colorText: Colors.white);
                                    //     return;
                                    //   }
                                    //   if (_toDestination == null) {
                                    //     Get.snackbar("Failed",
                                    //         "Please Select Your Arrival Destination",
                                    //         backgroundColor: Colors.orange,
                                    //         colorText: Colors.white);
                                    //     return;
                                    //   }
                                    //   if (_fromDestination!.id == _toDestination!.id) {
                                    //     Get.snackbar(
                                    //         "Failed", "Destinations Must Be Different!",
                                    //         backgroundColor: Colors.orange,
                                    //         colorText: Colors.white);
                                    //     return;
                                    //   } else {
                                    //     Get.to(() => TripSearchListView(
                                    //         fro: _fromDestination!,
                                    //         to: _toDestination!));
                                    //   }
                                    // },
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
                              color: Colors.black.withOpacity(0.5),
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
                                            List<String> results = [];
                                            if (val.trim().isNotEmpty) {
                                              for (int i = 0;
                                                  i < _items.length;
                                                  i++) {
                                                if (_items[i]
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
                                                    .map((item) => Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10),
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
                                                                item,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .white),
                                                              )
                                                            ],
                                                          ),
                                                        ))
                                                    .toList()
                                              ]
                                            : [
                                                ..._selItems
                                                    .map((item) => Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10),
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
                                                                item,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .white),
                                                              )
                                                            ],
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

                                !showMenu ? GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      showMenu = true;
                                    });
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    child:
                                    Stack(
                                      children: [
                                        Image.asset(
                                            'assets/images/image1.png'),
                                        const Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.menu,
                                                color: Colors.white,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ) :
                                Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 200,
                                      margin: EdgeInsets.symmetric(vertical: 2),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: const Icon(
                                              Icons.info,
                                              color: Color(0xffffffff),
                                            ),
                                            decoration: BoxDecoration(
                                              // color: Color(0xffE4181D),
                                                color: Colors.black,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    50)),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 100,
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "Help?",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.red[900],
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10)),
                                          )
                                        ],
                                      ),
                                    ),

                                    Container(
                                      height: 50,
                                      width: 200,
                                      margin: EdgeInsets.symmetric(vertical: 2),
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
                                          Container(
                                            height: 40,
                                            width: 100,
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
                                                BorderRadius.circular(
                                                    10)),
                                          )
                                        ],
                                      ),
                                    ),

                                    Container(
                                      height: 70,
                                      width: 200,
                                      margin: EdgeInsets.symmetric(vertical: 2),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                showMenu = false;
                                              });
                                            },
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              child:
                                              Stack(
                                                children: [
                                                  Container(
                                                    child: Image.asset(
                                                        'assets/images/stop.png'),
                                                  ),
                                                  const Align(
                                                      alignment: Alignment.bottomLeft,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                        child: Icon(
                                                          Icons.cancel_outlined,
                                                          color: Colors.white,
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

                                // Text("My App"),
                                // Container(
                                //   height: 50,
                                //   width: 60,
                                //   decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(10)),
                                //   child: IconButton(
                                //     icon: Icon(_isSearching
                                //         ? Icons.close
                                //         : Icons.search),
                                //     onPressed: () {
                                //       setState(() {
                                //         _isSearching = !_isSearching;
                                //       });
                                //     },
                                //   ),
                                // ),
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
