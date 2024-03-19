import 'package:flutter/material.dart';

var textFormFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red[100]!),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFE4191D)),
  ),
);
