import 'package:flutter/material.dart';
import 'package:bus_stop/models/user.dart';

class MyProfileView extends StatefulWidget {
  final Client client;
  const MyProfileView({super.key, required this.client});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 400,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width: 20,
                          height: 25,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          )),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "My Account",
                                  style: textTheme.bodyLarge!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              radius: 50,
                              child: Icon(
                                Icons.person_pin,
                                size: 40,
                                color: Colors.red,
                              ), //Text
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.client.username,
                                  style: textTheme.bodyMedium!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue[800]),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.client.email,
                                  style: textTheme.bodyMedium!.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue[800]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.lock,
                  color: Colors.red,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                title: const Text('Deactivate My Account'),
                onTap: () {},
              ),
              SizedBox(height: 5,),
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                title: const Text('Delete My Account'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
