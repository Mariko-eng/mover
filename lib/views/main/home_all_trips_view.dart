import 'package:bus_stop/controllers/locController.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/views/pages/trips/search.dart';
import 'package:bus_stop/views/pages/trips/widgets/tripTile.dart';
// import 'package:bus_stop/views/v2/widgets/bottom_bar_widget.dart';
import 'package:bus_stop/views/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/controllers/authController.dart';

class HomeAllTripsView extends StatefulWidget {
  const HomeAllTripsView({super.key});

  @override
  State<HomeAllTripsView> createState() => _HomeAllTripsViewState();
}

class _HomeAllTripsViewState extends State<HomeAllTripsView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSearching = false;

  void _setIsSearching () {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    LocationController controller = Get.find();

    controller.activeTrips();

    List<Trip> data = controller.trips;

    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            key: scaffoldKey,
            appBar: buildHomeAppBar(
                scaffoldKey: scaffoldKey, context: context, title: "Trips"),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: (){
                _setIsSearching();
              },
              child: Icon(Icons.search,color: Colors.white,),
            ),
            body: userProvider.client == null
                ? Container()
                : Obx(() => Column(
                      children: [
                        Visibility(
                            visible: controller.isTripsLoading.value,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            )),
                        Expanded(
                            child: controller.isTripsLoading.value && data.isEmpty
                                ? Container()
                                : controller.isTripsError.value
                                    ? Center(
                                        child: Text("Something Went Wrong!"),
                                      )
                                    : data.isEmpty
                                        ? Center(
                                            child: Text("No Results Found!"),
                                          )
                                        : ListView.builder(
                                            itemCount: data.length,
                                            itemBuilder: (context, int index) {
                                              return TripTile(
                                                  client: userProvider.client!,
                                                  trip: data[index]);
                                            }))
                      ],
                    )),
          ),
          Visibility(
              visible: _isSearching,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                // color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 10, right: 10, bottom: 10),
                  child:
                  AllTripsSearchView(
                    isSearching: _isSearching,
                    setIsSearching: _setIsSearching,

                  ),
                ),
              ))
        ],
      ),
    );
  }
}
