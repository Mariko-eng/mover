import 'package:bus_stop/services/communication.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop/models/busCompany.dart';

class BusCompanyProfile extends StatefulWidget {
  final BusCompany company;

  const BusCompanyProfile({Key? key, required this.company}) : super(key: key);

  @override
  _BusCompanyProfileState createState() => _BusCompanyProfileState();
}

class _BusCompanyProfileState extends State<BusCompanyProfile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBusCompanyProfile(userId: widget.company.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            BusCompany data = snapshot.data;
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
                    "Company Profile",
                    style: TextStyle(color: Colors.red[900]),
                  )),
              body: Card(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Name"),
                          data.name == null
                              ? const Text("None")
                              : Text(data.name)
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
                          const Text("Account Email"),
                          data.email == null
                              ? const Text("None")
                              : Text(data.email)
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
                          const Text("Contact Email"),
                          data.contactEmail == null
                              ? const Text("None")
                              : Text(data.contactEmail)
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
                          const Text("Phone"),
                          data.phoneNumber == null
                              ? const Text("None")
                              : Text(data.phoneNumber)
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
                          const Text("HotLine"),
                          data.hotLine == null
                              ? const Text("None")
                              : Text(data.hotLine)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async{
                                await makePhoneCall(data.phoneNumber);
                              },
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  )),
                            ),
                            Text(
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
                              onTap: () async{
                                if(data.hotLine == null) {
                                  await makePhoneCall(data.phoneNumber);
                                }else{
                                  await makePhoneCall(data.hotLine);
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50)
                                ),
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
                              onTap: () async{
                                if(data.hotLine == null) {
                                  await makePhoneCall(data.phoneNumber);
                                }else{
                                  await makePhoneCall(data.hotLine);
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50)
                                ),
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
                    )
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Container(),
            );
          }
        });
  }
}
