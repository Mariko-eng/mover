import 'package:flutter/material.dart';

AppBar buildHomeAppBar({required GlobalKey<ScaffoldState> scaffoldKey, required BuildContext context, required String title}) {
  return AppBar(
    backgroundColor: Color(0xfffdfdfd),
    elevation: 0,
    centerTitle: true,
    leading: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
          width: 20,
          height: 25,
          child: Image.asset(
            'assets/images/back_arrow.png',
          )),
    ),
    title: Text(
      title.toUpperCase(),
      style: TextStyle(color: Colors.red[900]),
    ),
  );
}

// AppBar buildHomeAppBar({required GlobalKey<ScaffoldState> scaffoldKey, required BuildContext context, required String title}) {
//   return AppBar(
//     backgroundColor: Color(0xfffdfdfd),
//     elevation: 0,
//     centerTitle: true,
//     leading: GestureDetector(
//       onTap:(){
//         scaffoldKey.currentState!.openDrawer();
//       },
//       child: Container(
//         height: 70,
//         width: 90,
//         margin: EdgeInsets.only(left: 20),
//         child: Stack(
//           children: [
//             Image.asset(
//               'assets/images/image1.png',
//               height: 70,
//               width: 90,
//             ),
//             const Positioned(
//                 left: 4,
//                 bottom: 10,
//                 child: Icon(Icons.menu,
//                   color: Colors.white,
//                   size: 18,
//                 ))
//           ],
//         ),
//       ),
//     ),
//     title: Text(
//       title.toUpperCase(),
//       style: TextStyle(color: Colors.red[900]),
//     ),
//   );
// }
