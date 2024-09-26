import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeInOut(
      color: Theme.of(context).primaryColor,
      size: 30,
    );
  }
}
