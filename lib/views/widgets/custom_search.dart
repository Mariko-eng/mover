import 'package:flutter/material.dart';

class CustomSearchWidget extends SearchDelegate {
  // List<String> searchTerms;
  //
  // CustomSearchWidget({required this.searchTerms});

  List<String> searchTerms = [
    "Masaka",
    "Kampala",
    "Ntinda",
    "Mutingo"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
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
    List<String> matches = [];

    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matches.add(item);
      }
    }

    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context, int index) {
            return ListTile(
              title: Text(matches[index]),
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matches = [];

    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matches.add(item);
      }
    }

    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context, int index) {
            return ListTile(
              title: Text(matches[index]),
            );
          }),
    );
  }
}
