import 'package:bus_stop/models/busCompany.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';


class CustomSearchBusCompanyWidget extends SearchDelegate {
  final Function(BusCompany) setBusCompany;
  final Function(String) setBusCompanyId;

  CustomSearchBusCompanyWidget({required this.setBusCompanyId,required this.setBusCompany});

  Future<List<BusCompany>>? _activeCompaniesFuture;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    // Only fetch active trips the first time this method is called
    if (_activeCompaniesFuture == null) {
      _activeCompaniesFuture = fetchBusCompanies();
    }

    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder(
        // future: fetchBusCompanies(),
        future: _activeCompaniesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "Something Went Wrong!",
                  style: textTheme.bodyMedium!
                      .copyWith(color: Colors.black, fontSize: 15),
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Container(
                color: Colors.white,
                child: const Center(child: LoadingWidget()));
          }

          List<BusCompany> companies = [
            BusCompany(
                uid: "",
                name: "None",
                email: "",
                contactEmail: "",
                phoneNumber: "",
                hotLine: "",
                logo: "")
          ];

          List<BusCompany> companiesList = snapshot.data ?? [];

          companies.addAll(companiesList);

          List<BusCompany> matches = [];

          for (var item in companies) {
            if (item.name
                .toLowerCase()
                .contains(query.toLowerCase())) {
              matches.add(item);
            }
          }

          return Container(
            color: Colors.white,
            child: ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                      onTap: () {
                        setBusCompany(matches[index]);
                        setBusCompanyId(matches[index].uid);
                        close(context, null);
                      },
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          // leading: Icon(Icons.bus_alert, color: Theme.of(context).primaryColor,),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          title: Text(matches[index].name),
                        ),
                      ));
                }),
          );
        });
  }
}
