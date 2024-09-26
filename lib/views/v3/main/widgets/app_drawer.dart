import 'package:flutter/material.dart';

class AppDrawerWidget extends StatefulWidget {
  const AppDrawerWidget({super.key});

  @override
  State<AppDrawerWidget> createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: Color(0xffffffff),
      child: Column(
        children: [
          Expanded(
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
                            style: textTheme.bodyMedium!.copyWith(
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Icon(Icons.person_outline),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        '+25677212412221',
                        style: textTheme.bodyMedium!.copyWith(
                          color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                      Icons.person
                  ),
                  title: Text(
                    'My Profile',
                    style: textTheme.bodyMedium!.copyWith(
                        color: Colors.black
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                      Icons.settings
                  ),
                  title: Text(
                    'Settings',
                    style: textTheme.bodyMedium!.copyWith(
                        color: Colors.black
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                      Icons.info
                  ),
                  title: Text(
                    'About us',
                    style: textTheme.bodyMedium!.copyWith(
                        color: Colors.black
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                      Icons.feedback
                  ),
                  title: Text(
                    'Help & Support',
                    style: textTheme.bodyMedium!.copyWith(
                        color: Colors.black
                    ),
                  ),
                ),

              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout
            ),
            title: Text(
              'Logout',
              style: textTheme.bodyMedium!.copyWith(
                  color: Colors.black
              ),
            ),
          )
        ],
      ),
    );
  }
}
