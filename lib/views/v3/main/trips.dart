import 'package:flutter/material.dart';
import 'package:flutter_horizontal_date_picker/flutter_horizontal_date_picker.dart';

class TripsView extends StatefulWidget {
  const TripsView({super.key});

  @override
  State<TripsView> createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView> {
  DateTime selected0 = DateTime.now().to000000;

  bool use000000 = false;
  DateTime get _now => use000000 ? DateTime.now().to000000 : DateTime.now();

  Duration _kSampleDurationToEndDay = Duration(days: 10);

  Color bgColor = Colors.grey.shade200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffffffff),
        automaticallyImplyLeading: false,
        leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
        centerTitle: true,
        title: Text("Trips",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xffffffff),
            child: HorizontalDatePicker(
              needFocus: true,
              begin: _now,
              end: _now.add(_kSampleDurationToEndDay),
              selected: selected0,
              onSelected: (item) {
                setState(() {
                  selected0 = item;
                });
              },
              selectedColor: Colors.transparent,
              unSelectedColor: Colors.transparent,
              itemBuilder: (DateTime itemValue, DateTime? selected) {

                var itemValueEdit = DateTime(itemValue.year,itemValue.month,itemValue.day);
                var selectedEdit = DateTime(selected!.year,selected.month,selected.day);

                // print("itemValue : " + itemValueEdit.toString() + " " + "selected : " + selectedEdit.toString());

                bool isSelected = itemValueEdit.toString() == selectedEdit.toString();
                // bool isSelected = selected?.difference(itemValue).inMilliseconds == 0;

                return Container(
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 5,
                        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      itemValue.toLocal().formatted(pattern: isSelected ? "EEE dd/MM" : "EEE, dd/MM"), // Ensure you have 'toLocal()' if using DateTime UTC
                      style: TextStyle(
                          color: isSelected ? Colors.black : Colors.black54,
                          fontSize: isSelected ? 14 : 10,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
              itemCount: 10,
              itemSpacing: 7,
            ),
          ),

          SizedBox(height: 20,),

          TripWidget(
              dottedLineColor : bgColor
          ),

          SizedBox(height: 20,),

        ],
      ),
    );
  }
}

class TripWidget extends StatefulWidget {
  final Color dottedLineColor;

  const TripWidget({super.key, required this.dottedLineColor});

  @override
  State<TripWidget> createState() => _TripWidgetState();
}

class _TripWidgetState extends State<TripWidget> {
  double contentHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Thausi Coaches UG",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ],),

                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Kampala Kampala Kampala",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text("08:00 AM",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: 100,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    color: Colors.red.shade100,
                                  ),
                                ),
                                Icon(Icons.bus_alert_outlined,
                                  color: Colors.blueGrey,),
                                Expanded(
                                  child: Container(
                                    height: 2,
                                    color: Colors.red.shade100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Masaka",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text("08:00 AM",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xffffffff),
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: widget.dottedLineColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: Offset(1,0)
                          ),
                          BoxShadow(
                              color: widget.dottedLineColor,
                              offset: Offset(-15, 0)
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Calculate the number of items based on the width of the parent widget.
                        final itemCount = (constraints.maxWidth / 10).floor();

                        return Flex(
                          children: List.generate(
                            itemCount,
                                (index) => SizedBox(
                              height: 1,
                              width: 5,
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: Colors.black54),
                              ),
                            ),
                          ),
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 20,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        // border: Border(
                        //   right: BorderSide(color: Colors.white)
                        // ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        color: widget.dottedLineColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: Offset(-1,0)
                          ),
                          BoxShadow(
                              color: widget.dottedLineColor,
                              offset: Offset(15, 0)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 15), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xffcd181a),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text("60,000 SHS",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18,
                              color: Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}





