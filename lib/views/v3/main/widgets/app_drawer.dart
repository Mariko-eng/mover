import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:bus_stop/controllers/authController.dart';

class AppDrawerWidget extends StatefulWidget {
  const AppDrawerWidget({super.key});

  @override
  State<AppDrawerWidget> createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: Color(0xffffffff),
      child: Column(
        children: [
          userProvider.client == null
              ? Container()
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                            // color: Colors.blue,
                            ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.arrow_back_ios),
                                Text(
                                  'Back',
                                  style: textTheme.bodyMedium!
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Icon(Icons.person_outline),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              userProvider.client!.username,
                              style: textTheme.bodyMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          'My Profile',
                          style: textTheme.bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text(
                          'Settings',
                          style: textTheme.bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text(
                          'About us',
                          style: textTheme.bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.feedback),
                        title: Text(
                          'Help & Support',
                          style: textTheme.bodyMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
          ListTile(
            onTap: () {
              _logoutDialog(userProvider);
            },
            leading: const Icon(Icons.logout),
            title: Text(
              'Logout',
              style: textTheme.bodyMedium!.copyWith(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  void _logoutDialog(UserProvider userProvider) {
    Get.back();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(builder: (context) {
                var height = 50.0;
                var width = MediaQuery.of(context).size.width * 0.8;

                return Container(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Are You Sure You Want Logout?.",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "NO",
                              style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).primaryColor,
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.of(context).pop();
                          userProvider.signOut();
                        },
                        child: Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text("YES",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ))),
                      ),
                    )
                  ],
                )
              ],
            );
          });
        });
  }
}
