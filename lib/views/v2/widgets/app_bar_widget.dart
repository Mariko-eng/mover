import 'package:flutter/material.dart';

AppBar buildTopAppBar({required BuildContext context, required String title}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xfffdfdfd),
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
