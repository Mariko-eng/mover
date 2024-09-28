import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  const LoadingWidget({ Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeInOut(
      color: color ?? Theme.of(context).primaryColor,
      size: 30,
    );
  }
}
