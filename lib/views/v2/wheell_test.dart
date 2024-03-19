import 'package:flutter/material.dart';

class Person {
  String name;

  Person({required this.name});
}

class WheelTestView extends StatefulWidget {
  const WheelTestView({Key? key}) : super(key: key);

  @override
  _WheelTestViewState createState() => _WheelTestViewState();
}

class _WheelTestViewState extends State<WheelTestView> {
  List<Person> people = [
    Person(name: "Mark"),
    Person(name: "James"),
    Person(name: "Micheal"),
    Person(name: "Peter"),
    Person(name: "Owen"),
    Person(name: "Letia"),
  ];

  String selectedPerson = "Mark";
  List<String> items = ["1", "2", "3", "4", "5"];

  // String selecteditem = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.blueGrey.shade900,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Item",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              height: 60,
                              width: 200,
                              child: Center(
                                child: Container(
                                  height: 65,
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade800,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.arrow_left,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      Icon(
                                        Icons.arrow_right,
                                        size: 30,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        ListWheelScrollView.useDelegate(
                            itemExtent: 50,
                            physics: FixedExtentScrollPhysics(),
                            perspective: 0.001,
                            diameterRatio: 0.7,
                            squeeze: 1.0,
                            useMagnifier: true,
                            magnification: 1.3,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedPerson = people[index].name;
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                                childCount: people.length,
                                builder: (context, index) {
                                  return WheelTile(
                                    selectedColor:
                                        selectedPerson == people[index].name
                                            ? Colors.white
                                            : Colors.white54,
                                    person: people[index],
                                  );
                                })),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
    // return Scaffold(
    //   body: SafeArea(
    //     child: Container(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Row(
    //             children: [
    //               SizedBox(
    //                 width: 100,
    //                 height: 100,
    //                 child: ListWheelScrollView.useDelegate(
    //                     itemExtent: 55,
    //                     onSelectedItemChanged: (val){
    //                       setState(() {
    //                         selecteditem = items[val];
    //                       });
    //                     },
    //                     childDelegate: ListWheelChildBuilderDelegate(
    //                       builder: (BuildContext context, int index){
    //                         if(index < 0 || index > 4){
    //                           return null;
    //                         }
    //                         return GestureDetector(
    //                           onTap: (){
    //                             setState(() {
    //                               selecteditem = items[index];
    //                               print(selecteditem);
    //                               print(items[index]);
    //                             });
    //                           },
    //                             child: Text(items[index],
    //                             style: TextStyle(
    //                               color: selecteditem == items[index] ? Colors.blue : Colors.black87
    //                             ),
    //                             ),);
    //                       }
    //                     )),
    //                 // child: ListWheelScrollView(
    //                 //     itemExtent: 20,
    //                 //     onSelectedItemChanged: (val){
    //                 //       print(val);
    //                 //     },
    //                 //
    //                 //     children: [
    //                 //       Text("1"),
    //                 //       Text("2"),
    //                 //       Text("3"),
    //                 //       Text("4"),
    //                 //       Text("5"),
    //                 //       Text("6"),
    //                 //     ]),
    //               )
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class WheelTile extends StatelessWidget {
  final Person person;
  final Color selectedColor;

  const WheelTile({Key? key, required this.person, required this.selectedColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          person.name,
          style: TextStyle(color: selectedColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
