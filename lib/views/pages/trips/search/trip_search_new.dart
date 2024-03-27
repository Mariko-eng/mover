import 'package:bus_stop/models/destination/destination.dart';
import 'package:bus_stop/views/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripSearchNewView extends StatefulWidget {
  final Function setPlace;

  const TripSearchNewView({
    super.key,
    required this.setPlace,
  });

  @override
  State<TripSearchNewView> createState() => _TripSearchNewViewState();
}

class _TripSearchNewViewState extends State<TripSearchNewView> {
  final _searchCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTopAppBar(context: context, title: "Select Destination"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                      height: 50,
                      child: TextField(
                        controller: _searchCtr,
                        onChanged: (String? val) {
                          if (val != null) {
                            if (val.trim().isNotEmpty) {
                              setState(() {});
                            }
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Search Your Location...",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.red)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.red,
                            )),
                      ),
                    ))
              ],
            ),
            StreamBuilder(
                stream: getDestinations(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Something has Gone Wrong!"),
                            ],
                          ),
                        ));
                  }
                  if (!snapshot.hasData) {
                    return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ));
                  } else {
                    List<Destination>? data = snapshot.data;
                    return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ListView.builder(
                              itemCount: data!.length,
                              itemBuilder: (context, int i) {
                                if (_searchCtr.text.trim().isNotEmpty) {
                                  if (data[i].name.toLowerCase().contains(
                                      _searchCtr.text.trim().toLowerCase())) {
                                    return Card(
                                      child: ListTile(
                                        onTap: () {
                                          widget.setPlace(data[i]);
                                          Get.back();
                                        },
                                        leading: const Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                        ),
                                        title: Text(snapshot.data![i].name),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                } else {
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                        widget.setPlace(data[i]);
                                        Get.back();
                                      },
                                      leading: const Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                      title: Text(snapshot.data![i].name),
                                    ),
                                  );
                                }
                              }),
                        ));
                  }
                })
          ],
        ),
      ),
    );
  }
}
