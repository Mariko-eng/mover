import 'package:flutter/material.dart';
import 'package:bus_stop/models/destination/destination.dart';

class CustomSearchDestinationWidget extends SearchDelegate {
  List<Destination> searchTerms;
  final Function(Destination) setPlace;
  final Function(Destination) setDestination;

  CustomSearchDestinationWidget({required this.setDestination,required this.searchTerms, required this.setPlace});

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
    List<Destination> matches = [];

    for (var item in searchTerms) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matches.add(item);
      }
    }

    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context, int index) {
            return ListTile(
              title: Text(matches[index].name),
              onTap:  () {
                setPlace(matches[index]);
                setDestination(matches[index]);
                close(context, null);
              },
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Destination> matches = [];

    for (var item in searchTerms) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matches.add(item);
      }
    }

    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context, int index) {
            return ListTile(
              title: Text(matches[index].name),
              onTap:  () {
                setPlace(matches[index]);
                setDestination(matches[index]);
                close(context, null);
              },
            );
          }),
    );
  }
}
