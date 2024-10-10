import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bus_stop/models/appSettingsProfile.dart';
import 'package:bus_stop/services/communication.dart';
import 'package:bus_stop/views/widgets/loading_widget.dart';

class HelpAndSupportView extends StatefulWidget {
  const HelpAndSupportView({super.key});

  @override
  State<HelpAndSupportView> createState() => _HelpAndSupportViewState();
}

class _HelpAndSupportViewState extends State<HelpAndSupportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Help & Support",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: appProfileSettings(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              AppProfileSettings? data = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.mail),
                          title: Text("Email Address"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(data!.email1)],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.mail),
                          title: Text("Phone Number"),
                          trailing: GestureDetector(
                              onTap: () {
                                makePhoneCall(data.phone1);
                              },
                              child: Icon(
                                Icons.phone,
                                color: Colors.green[900],
                              )),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(data.phone1)],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.mail),
                          title: Text("Hotline"),
                          trailing: GestureDetector(
                              onTap: () {
                                makePhoneCall(data.hotline1);
                              },
                              child: Icon(
                                Icons.phone,
                                color: Colors.green[900],
                              )),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(data.hotline1)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                body: Center(
                  child: LoadingWidget(),
                ),
              );
            }
          }),
    );
  }
}
