import 'package:bus_stop/models/busCompany.dart';
import 'package:bus_stop/models/parkLocation.dart';
import 'package:bus_stop/views/busCompany/BusCompanyDestinationsMapView.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BusCompanyDestinations extends StatefulWidget {
  final BusCompany company;

  const BusCompanyDestinations({Key? key, required this.company}) : super(key: key);

  @override
  _BusCompanyDestinationsState createState() => _BusCompanyDestinationsState();
}

class _BusCompanyDestinationsState extends State<BusCompanyDestinations> {
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
            widget.company.name + " Destinations".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),
          )),
      body: StreamBuilder(
        stream: getBusCompanyDestinations(companyId: widget.company.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (kDebugMode) {
              print(snapshot.error);
            }
          }
          if (snapshot.hasData) {
            List<ParkLocations>? data = snapshot.data;
            if (data!.isEmpty) {
              return const Center(
                child: Text(
                  "No Destination Yet!",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, int index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BusCompanyDestinationsMapView(
                                      data: data[index],
                                    )));
                      },
                      leading: const Icon(Icons.arrow_right_sharp),
                      title: Text(data[index].destinationName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index].parkLocationName),
                          Text("(" +
                              data[index].positionLat.toString() +
                              " , " +
                              data[index].positionLng.toString() +
                              ")")
                        ],
                      ),
                    );
                  }),
            );
          } else {
            // print("Here2");
            return Container();
          }
        },
      ),
    );
  }
}
