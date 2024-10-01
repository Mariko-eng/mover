// import 'package:bus_stop/views/pages/settings/ContactUsView.dart';
// import 'package:bus_stop/views/pages/settings/MyTransactionsView.dart';
// import 'package:bus_stop/views/pages/settings/TermsOfServiceView.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:bus_stop/controllers/authController.dart';
//
// class SettingsView extends StatefulWidget {
//   const SettingsView({super.key});
//
//   @override
//   State<SettingsView> createState() => _SettingsViewState();
// }
//
// class _SettingsViewState extends State<SettingsView> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.sizeOf(context);
//     final textTheme = Theme.of(context).textTheme;
//
//     UserProvider userProvider = Provider.of<UserProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 260,
//         automaticallyImplyLeading: false,
//         flexibleSpace: SafeArea(
//           child: Container(
//             margin: EdgeInsets.symmetric(vertical: 10),
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 1.0,
//                   spreadRadius: 1.0,
//                   offset: const Offset(0.0, 1.0),
//                 )
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Container(
//                           width: 20,
//                           height: 25,
//                           child: Image.asset(
//                             'assets/images/back_arrow.png',
//                           )),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 180,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "My Account",
//                                   style: textTheme.bodyLarge!.copyWith(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.black),
//                                 ),
//                               ],
//                             ),
//                             CircleAvatar(
//                               backgroundColor: Colors.grey.withOpacity(0.1),
//                               radius: 50,
//                               child: Icon(
//                                 Icons.person_pin,
//                                 size: 40,
//                                 color: Colors.red,
//                               ), //Text
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   userProvider.client == null
//                                       ? "..."
//                                       : userProvider.client!.email,
//                                   style: textTheme.bodyLarge!.copyWith(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.blue),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               ListTile(
//                 leading: Icon(
//                   Icons.receipt,
//                   color: Colors.red,
//                 ),
//                 trailing: Icon(Icons.arrow_forward_ios),
//                 title: const Text('My Transactions'),
//                 onTap: () {
//                   if (userProvider.client != null) {
//                     Get.to(() => MyTransactionsView(
//                           clientId: userProvider.client!.uid,
//                         ));
//                   }
//                 },
//               ),
//               Divider(),
//               ListTile(
//                 leading: Icon(
//                   Icons.phone,
//                   color: Colors.red,
//                 ),
//                 trailing: Icon(Icons.arrow_forward_ios),
//                 title: const Text('Contact Us'),
//                 onTap: () {
//                   Get.to(() => ContactUsView());
//                 },
//               ),
//               Divider(),
//               ListTile(
//                 leading: Icon(
//                   Icons.folder_copy_outlined,
//                   color: Colors.red,
//                 ),
//                 trailing: Icon(Icons.arrow_forward_ios),
//                 title: const Text('Terms Of Service'),
//                 onTap: () {
//                   Get.to(() => TermsOfServiceView());
//                 },
//               ),
//               Divider(),
//               ListTile(
//                 leading: Icon(
//                   Icons.delete,
//                   color: Colors.red,
//                 ),
//                 trailing: Icon(Icons.arrow_forward_ios),
//                 title: const Text('Delete My Account'),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
