import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key, required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        width: size.width,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xffe5e5e5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: child,
      ),
    );
  }
}
