import 'package:flutter/material.dart';
import 'package:bus_stop/models/busCompany.dart';
import 'package:get/get.dart';

class SelectBusCompanyView extends StatefulWidget {
  final Function selectBusCompany;

  const SelectBusCompanyView(
      {super.key, required this.selectBusCompany});

  @override
  State<SelectBusCompanyView> createState() => _SelectBusCompanyViewState();
}

class _SelectBusCompanyViewState extends State<SelectBusCompanyView> {
  final TextEditingController _searchCtr = TextEditingController();

  List<BusCompany> searchResults = [];
  bool isSearching = false;
  String searchingError = "";
  String searchString = "";

  _getBusCompanies() async {
    List<BusCompany> results = await fetchBusCompanies();

    setState(() {
      searchResults = results;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBusCompanies();
  }

  @override
  Widget build(BuildContext context) {
    // print(searchResults);

    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Select Destination",
            style: TextStyle(
                color: Colors.black87, fontFamily: 'Overpass', fontSize: 20),
          ),
          elevation: 0.0),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextField(
                  controller: _searchCtr,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isSearching = false;
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
                    setState(() {
                      searchString = val.toLowerCase();
                    });
                  },
                ),
              ),
            ),
            Builder(builder: (context) {
              if (isSearching) {
                // State when fetching the data
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LoadingWidget()
                  ],
                );
              }
              if (searchingError != "") {
                return Expanded(
                  child: Center(
                    // child: CustomErrorWidget(
                    //   errorMessage: "Can't fetch data at this time! \n "
                    //       "Something went wrong!",
                    //   canRefresh: true,
                    //   onRefreshPage: () {
                    //     setState(() {});
                    //   },
                    // ),
                  ),
                );
              }
              if (searchResults.isEmpty) {
                return Expanded(
                    child: Container());
              }
              final results = _search(searchResults);

              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ..._buildWidgets(results),
                            ],
                          ),
                        )),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildWidgets(List<BusCompany> items) {
    return items
        .map((item) => GestureDetector(
      onTap: () {
        widget.selectBusCompany(item);
        Get.back();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.blue[900],
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              item.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 18, color: Colors.black),
            )
          ],
        ),
      ),
    ))
        .toList();
  }

  List<BusCompany> _search(List<BusCompany> data) {
    if (searchString.isNotEmpty == true) {
      //search logic what you want
      return data
          .where((element) => element.name.toLowerCase().contains(searchString))
          .toList();
    }
    return data;
  }
}
