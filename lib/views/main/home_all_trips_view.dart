import 'package:bus_stop/contollers/locController.dart';
import 'package:bus_stop/models/trip.dart';
import 'package:bus_stop/views/pages/trips/tripTile.dart';
// import 'package:bus_stop/views/v2/widgets/bottom_bar_widget.dart';
import 'package:bus_stop/views/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/contollers/authController.dart';

class HomeAllTripsView extends StatefulWidget {
  const HomeAllTripsView({super.key});

  @override
  State<HomeAllTripsView> createState() => _HomeAllTripsViewState();
}

class _HomeAllTripsViewState extends State<HomeAllTripsView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: scaffoldKey,
      appBar: buildHomeAppBar(
          scaffoldKey: scaffoldKey, context: context, title: "Trips"),
      // drawer: const DrawerView(),
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
    );
  }
}
