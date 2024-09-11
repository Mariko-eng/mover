import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> _items = ["Masaka", "Kampala", "Ntinda", "Jinja"];
  List<String> _selItems = [];

  final TextEditingController _fromCtr = TextEditingController();
  final TextEditingController _toCtr = TextEditingController();
  final TextEditingController _searchCtr = TextEditingController();

  String? _fromDestination;
  String? _toDestination;

  bool isFrom = true;

  bool _isSearching = false;

  _setPlace(String destination) {
    setState(() {
      if (isFrom) {
        if (_toCtr.text != destination) {
          _fromDestination = destination;
          _fromCtr.text = destination;
        }
      } else {
        if (_fromCtr.text != destination) {
          _toDestination = destination;
          _toCtr.text = destination;
        }
      }
      _isSearching = false;
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
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.blue,
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.05,
                // Height of the sheet as a fraction of the viewport height
                minChildSize: 0.05,
                maxChildSize: 0.7,
                builder: (BuildContext context, scrollController) {
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    // Builder should have a CustomScrollView widget to be able to scroll and drag the bottom sheet
                    child: CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).hintColor,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                              ),
                              height: 4,
                              width: 40,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),

                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      "Where would you like to go today?",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 40.0),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 200,
                                          // color: Colors.green,
                                          padding:
                                          EdgeInsets.only(top: 50, bottom: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 20,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                    BorderRadius.circular(15)),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                    color: Colors.red,
                                                    width: 5,
                                                  )),
                                              Container(
                                                width: 20,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                    BorderRadius.circular(15)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 200,
                                                // color: Colors.blue,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text("From"),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller: _fromCtr,
                                                          readOnly: true,
                                                          onTap: () {
                                                            setState(() {
                                                              isFrom = true;
                                                              _isSearching = true;
                                                            });
                                                          },
                                                          decoration: InputDecoration(
                                                              border:
                                                              OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              suffixIcon: Icon(
                                                                  Icons.search)),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'From';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text("To"),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller: _toCtr,
                                                          readOnly: true,
                                                          onTap: () {
                                                            setState(() {
                                                              isFrom = false;
                                                              _isSearching = true;
                                                            });
                                                          },
                                                          decoration: InputDecoration(
                                                              border:
                                                              OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10)
                                                              ),
                                                              suffixIcon: Icon(
                                                                  Icons.search)),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'To';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 30.0),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text("Agency"),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  TextFormField(
                                                    // controller: _nameController,
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                        border:
                                                        OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                        ),
                                                        suffixIcon: Icon(Icons
                                                            .keyboard_arrow_down)),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Agency';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40.0),
                                    Container(
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                                height: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                    BorderRadius.circular(10)),
                                                child: Text(
                                                  "Book The Trip",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // SliverList.list(children: const [
                        //   ListTile(title: Text('Jane Doe')),
                        //   ListTile(title: Text('Jack reacher')),
                        // ])
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          Visibility(
              visible: _isSearching,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Padding(
                  padding: EdgeInsets.only(top: statusBarHeight + 20, left: 10, right: 10),
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
                                  .map(
                                      (item) =>
                                      GestureDetector(
                                        onTap: () {
                                          _setPlace(item);
                                        },
                                        child: Container(
                                          margin: EdgeInsets
                                              .symmetric(
                                              vertical:
                                              10),
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
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList()
                            ]
                                : [
                              ..._selItems
                                  .map(
                                      (item) =>
                                      GestureDetector(
                                        onTap: () {
                                          _setPlace(item);
                                        },
                                        child: Container(
                                          margin: EdgeInsets
                                              .symmetric(
                                              vertical:
                                              10),
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
                                                    fontSize: 18,
                                                    color: Colors.white),
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
}
