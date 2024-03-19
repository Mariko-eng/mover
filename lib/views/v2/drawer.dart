// import 'package:bus_stop/views/travel/helpScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:bus_stop/contollers/authController.dart';
//
// class DrawerView extends StatefulWidget {
//   const DrawerView({Key? key}) : super(key: key);
//
//   @override
//   _DrawerViewState createState() => _DrawerViewState();
// }
//
// class _DrawerViewState extends State<DrawerView> {
//   @override
//   Widget build(BuildContext context) {
//     final UserProvider userProvider = Provider.of<UserProvider>(context);
//
//     return Drawer(
//       child: userProvider.client == null
//           ? Container()
//           : SafeArea(
//               child: Container(
//                 height: MediaQuery.of(context).size.height,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 100,
//                           width: 100,
//                           child: Padding(
//                             padding: const EdgeInsets.all(25.0),
//                             child: Center(
//                                 child: Image.asset(
//                               'assets/images/image12.png',
//                             )),
//                           ),
//                           decoration: BoxDecoration(
//                               color: Color(0xffE4181D),
//                               borderRadius: BorderRadius.circular(50)),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "bustop@gamil.com",
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline6!
//                               .copyWith(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w300,
//                                   color: Colors.red[900]),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           userProvider.client!.username,
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline6!
//                               .copyWith(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.red[900]),
//                         )
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Divider(
//                         color: Colors.red,
//                         thickness: 2,
//                       ),
//                     ),
//                     Expanded(
//                         child: SingleChildScrollView(
//                             child: Column(
//                       children: [
//                         ListTile(
//                           leading: Icon(
//                             Icons.receipt,
//                             color: Colors.red[200],
//                           ),
//                           title: Text("Coupons"),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Divider(
//                             color: Colors.red,
//                             thickness: 1,
//                           ),
//                         ),
//                         ListTile(
//                           leading: Icon(
//                             Icons.person,
//                             color: Colors.red[200],
//                           ),
//                           title: Text("My Profile"),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Divider(
//                             color: Colors.red,
//                             thickness: 1,
//                           ),
//                         ),
//                         ListTile(
//                           leading: Icon(
//                             Icons.question_answer,
//                             color: Colors.red[200],
//                           ),
//                           title: Text("FAQ"),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Divider(
//                             color: Colors.red,
//                             thickness: 1,
//                           ),
//                         ),
//                         ListTile(
//                           leading: Icon(
//                             Icons.info,
//                             color: Colors.red[200],
//                           ),
//                           title: Text("About Us"),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Divider(
//                             color: Colors.red,
//                             thickness: 1,
//                           ),
//                         ),
//                         ListTile(
//                           leading: Icon(
//                             Icons.star,
//                             color: Colors.red[200],
//                           ),
//                           title: Text("Rating"),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Divider(
//                             color: Colors.red,
//                             thickness: 1,
//                           ),
//                         ),
//                         ListTile(
//                           onTap: () {
//                             Get.back();
//                             Get.to(() => HelpScreen(client: userProvider.client!));
//                           },
//                           leading: Icon(
//                             Icons.help,
//                             color: Colors.red[200],
//                           ),
//                           title: Text("Help"),
//                         ),
//                       ],
//                     ))),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Divider(
//                         color: Colors.red,
//                         thickness: 2,
//                       ),
//                     ),
//                     ListTile(
//                       onTap: (){
//                         _logoutDialog(userProvider: userProvider);
//                       },
//                       leading: Icon(
//                         Icons.logout,
//                         color: Colors.red[200],
//                       ),
//                       title: Text("Logout"),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
//
//   void _logoutDialog({required UserProvider userProvider }) {
//     Get.back();
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (context) {
//           bool isLoading = false;
//           return StatefulBuilder(builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.zero,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10.0))),
//               content: Builder(builder: (context) {
//                 var height = 50.0;
//                 var width = MediaQuery.of(context).size.width * 0.8;
//
//                 return isLoading
//                     ? Container(
//                   height: height,
//                   width: width,
//                   child: Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.red,
//                     ),
//                   ),
//                 )
//                     : Container(
//                   height: height,
//                   width: width,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           "Are You Sure You Want Logout?.",
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//               actions: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           if (isLoading) {
//                             return;
//                           }
//                           Get.back();
//                         },
//                         child: Container(
//                             width: 100,
//                             height: 40,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 color: Colors.red[200],
//                                 border: Border.all(color: Colors.red[900]!),
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: Text(
//                               "NO",
//                               style: TextStyle(
//                                   fontSize: 17, color: Colors.red[900]),
//                             )),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () async {
//                           Navigator.of(context).pop();
//                           userProvider.signOut();
//                         },
//                         child: Container(
//                             width: 100,
//                             height: 40,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 color: Colors.red[900],
//                                 borderRadius: BorderRadius.circular(10)),
//                             child: const Text("YES",
//                                 style: TextStyle(
//                                   fontSize: 17,
//                                   color: Colors.white,
//                                 ))),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             );
//           });
//         });
//   }
//
// }
