import 'package:bus_stop/contollers/authController.dart';
import 'package:bus_stop/models/appSettingsProfile.dart';
import 'package:bus_stop/models/user.dart';
import 'package:bus_stop/services/communication.dart';
import 'package:bus_stop/services/local_storage.dart';
import 'package:bus_stop/views/auth/wrapper.dart';
import 'package:bus_stop/views/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HelpScreen extends StatefulWidget {
  final Client client;

  const HelpScreen({Key? key, required this.client}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _passwordCtr = TextEditingController();

  late Map prevTransData;

  _getPreviousTransactionData() async {
    Map data = await LocalStorageService().getTransData();
    setState(() {
      prevTransData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPreviousTransactionData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: appProfileSettings(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            AppProfileSettings? data = snapshot.data;
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
                  "ASK FOR HELP".toUpperCase(),
                  style: TextStyle(color: Colors.red[900]),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Email (1)"), Text(data!.email1)],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Email (2)"), Text(data.email2)],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Contact Phone (1)"),
                                Text(data.phone1)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Contact Phone (2)"),
                                Text(data.phone2)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("HotLine (1)"),
                                Text(data.hotline1)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("HotLine (2)"),
                                Text(data.hotline2)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await makePhoneCall(data.phone1);
                                      },
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: const Icon(
                                            Icons.phone,
                                            color: Colors.white,
                                          )),
                                    ),
                                    const Text(
                                      "Make Call",
                                      style: TextStyle(color: Colors.green),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await makePhoneCall(data.phone2);
                                      },
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: const Icon(
                                            Icons.phone,
                                            color: Colors.white,
                                          )),
                                    ),
                                    const Text(
                                      "Make Call",
                                      style: TextStyle(color: Colors.green),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (data.hotline1 == null) {
                                          await makePhoneCall(data.phone1);
                                        } else {
                                          await makePhoneCall(data.hotline1);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "HotLine(1) Call",
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (data.hotline2 == null) {
                                          await makePhoneCall(data.phone1);
                                        } else {
                                          await makePhoneCall(data.hotline2);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Icon(
                                          Icons.phone,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "HotLine(2) Call",
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text(
                                            "Do Want To delete This Account?"),
                                        actions: [
                                          GestureDetector(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Text("Cancel")),
                                          GestureDetector(
                                            onTap: () {
                                              Get.back();
                                              enterPasswordDialog(
                                                  email: widget.client.email);
                                            },
                                            child: Container(
                                              width: 80,
                                              height: 35,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              child: Text(
                                                "Ok",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.cancel,
                                    color: Color(0xff8c2636),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Delete This Account",
                                    style: TextStyle(
                                      color: Color(0xff8c2636),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (prevTransData != null)
                      prevTransData["transactionId"] == ""
                          ? Container()
                          : Card(
                              child: Column(
                                children: [
                                  Text("Previous Transaction Data"),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Transation Id"),
                                        Text(prevTransData['transactionId'])
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Tax Ref"),
                                        Text(prevTransData['txRef'])
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Transaction Status"),
                                        Text(prevTransData['transactionStatus'])
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Trip Number"),
                                        Text(prevTransData['tripNumber'])
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Company Name"),
                                        Text(prevTransData['companyName'])
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Ticket Type"),
                                        Text(prevTransData['ticketType'])
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Ticket Price"),
                                        Text(prevTransData['ticketPrice']
                                            .toString())
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("No Of Tickets"),
                                        Text(prevTransData['noOfTickets']
                                            .toString())
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Amount Paid"),
                                        Text(prevTransData['amountPaid'])
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            )
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Loading(),
              ),
            );
          }
        });
  }

  enterPasswordDialog({required String email}) {
    showDialog(
        context: context,
        builder: (context) {
          UserProvider _userProvider2 = Provider.of<UserProvider>(context);
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                children: [
                  Text("Confirm Your Password"),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordCtr,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  )
                ],
              ),
            ),
            actions: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Text("Cancel")),
              GestureDetector(
                onTap: () async {
                  if (_passwordCtr.text.trim().length > 5) {
                    Get.back();
                    bool res = await _userProvider2.deleteUserAccount(
                        email: email, password: _passwordCtr.text.trim());
                    if(res == true){
                      Get.offAll((AuthWrapper()));
                    }
                  } else {
                    Get.snackbar("Password Is Too short", "Try Again");
                  }
                },
                child: Container(
                  width: 80,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
