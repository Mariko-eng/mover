import 'package:bus_stop/views/v2/pages/cargo/new/select_locations_view.dart';
import 'package:bus_stop/views/v2/widgets/wheel_scroll_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop/models/user.dart';

class NewCargoOrderView extends StatefulWidget {
  final Client client;

  const NewCargoOrderView({super.key, required this.client});

  @override
  State<NewCargoOrderView> createState() => _NewCargoOrderViewState();
}

class _NewCargoOrderViewState extends State<NewCargoOrderView> {
  int? selectedWeight;
  List<int> weights = List.generate(250, (index) => index + 1);

  TextEditingController descCtr = TextEditingController();
  String descError = "";
  TextEditingController weightCtr = TextEditingController();
  String weightError = "";
  TextEditingController senderNameCtr = TextEditingController();
  String senderNameError = "";
  TextEditingController senderPhoneCtr = TextEditingController();
  String senderPhoneError = "";
  TextEditingController receiverNameCtr = TextEditingController();
  String receiverNameError = "";
  TextEditingController receiverPhoneCtr = TextEditingController();
  String receiverPhoneError = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Enter Package Information",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Package Description",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                minLines: 2,
                                maxLines: 3,
                                controller: descCtr,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          )
                        ],
                      ),
                      descError == ""
                          ? Container()
                          : Text(
                              descError,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 10),
                            )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Estimated Package Weight In Kgs",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextField(
                                controller: weightCtr,
                                readOnly: true,
                                onTap: () {
                                  _showNoOfTablesBottomSheet();
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          )
                        ],
                      ),
                      weightError == ""
                          ? Container()
                          : Text(
                              weightError,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 10),
                            )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sender Names",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextField(
                                controller: senderNameCtr,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          )
                        ],
                      ),
                      senderNameError == ""
                          ? Container()
                          : Text(
                              senderNameError,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 10),
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Sender Phone Number",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextField(
                                controller: senderPhoneCtr,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          )
                        ],
                      ),
                      senderPhoneError == ""
                          ? Container()
                          : Text(
                              senderPhoneError,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 10),
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Receiver Names",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextField(
                                controller: receiverNameCtr,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          )
                        ],
                      ),
                      receiverNameError == ""
                          ? Container()
                          : Text(
                              receiverNameError,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 10),
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Receiver Phone Number",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              child: TextField(
                                controller: receiverPhoneCtr,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          )
                        ],
                      ),
                      receiverPhoneError == ""
                          ? Container()
                          : Text(
                              receiverPhoneError,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 10),
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if (descCtr.text.trim().length < 5) {
                      setState(() {
                        descError = "Provide a valid package description";
                      });
                      return;
                    } else {
                      setState(() {
                        descError = "";
                      });
                    }
                    if (weightCtr.text.trim().isEmpty) {
                      setState(() {
                        weightError = "Provide a select package weight";
                      });
                      return;
                    } else {
                      setState(() {
                        weightError = "";
                      });
                    }
                    if (senderNameCtr.text.trim().length < 2) {
                      setState(() {
                        senderNameError = "Provide a valid sender name/s";
                      });
                      return;
                    } else {
                      setState(() {
                        senderNameError = "";
                      });
                    }
                    if (senderPhoneCtr.text.trim().length < 10) {
                      setState(() {
                        senderPhoneError =
                            "Provide a valid sender phone number";
                      });
                      return;
                    } else {
                      setState(() {
                        senderPhoneError = "";
                      });
                    }
                    if (receiverNameCtr.text.trim().length < 2) {
                      setState(() {
                        receiverNameError = "Provide a valid receiver name/s";
                      });
                      return;
                    } else {
                      setState(() {
                        receiverNameError = "";
                      });
                    }

                    if (receiverPhoneCtr.text.trim().length < 10) {
                      setState(() {
                        receiverPhoneError =
                            "Provide a valid receiver phone number";
                      });
                      return;
                    } else {
                      setState(() {
                        receiverPhoneError = "";
                      });
                    }
                    if(selectedWeight !=  null) {
                      Get.to(() =>
                          SelectPickUpAndDropOffView(
                            client: widget.client,
                            packageDesc: descCtr.text,
                            weight: selectedWeight!,
                            senderName: senderNameCtr.text,
                            senderPhone: senderPhoneCtr.text,
                            receiverName: receiverNameCtr.text,
                            receiverPhone: receiverPhoneCtr.text,
                          ));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.red[900],
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text(
                      "Select Pickup & DropOff",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  _showNoOfTablesBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text("Estimated weight",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                  )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text("Select",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  )),
                        )
                      ],
                    ),
                  ),
                  StatefulBuilder(builder: (context, setState2) {
                    return Expanded(
                      child: Stack(
                        children: [
                          ListWheelScrollView.useDelegate(
                            controller:
                                FixedExtentScrollController(initialItem: 0),
                            itemExtent: 60,
                            physics: FixedExtentScrollPhysics(),
                            perspective: 0.001,
                            diameterRatio: 0.7,
                            squeeze: 1.0,
                            useMagnifier: true,
                            magnification: 1.3,
                            onSelectedItemChanged: (index) {
                              setState2(() {
                                selectedWeight = weights[index];
                                weightCtr.text = weights[index].toString();
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                                childCount: weights.length,
                                builder: (context, index) {
                                  return WheelScrollTileWidget(
                                    selectedColor:
                                        selectedWeight == weights[index]
                                            ? Theme.of(context).primaryColor
                                            : Colors.black,
                                    item: weights[index].toString(),
                                    selectedFontSize:
                                        selectedWeight == weights[index]
                                            ? 20
                                            : 12,
                                    isSelected: selectedWeight == weights[index]
                                        ? true
                                        : false,
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        });
  }
}
