import 'package:flutter/material.dart';

class WheelScrollTileWidget extends StatelessWidget {
  final String item;
  final Color selectedColor;
  final double selectedFontSize;
  final bool isSelected;

  const WheelScrollTileWidget(
      {Key? key,
      required this.item,
      required this.selectedColor,
        required this.selectedFontSize,
        required this.isSelected,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: isSelected ? Border.all(
                color: Theme.of(context).primaryColor
              ) : Border.all(
                color: Colors.white
              )
            ),
            child: Text(
              item.toUpperCase(),
              style: TextStyle(
                  color: selectedColor,
                  fontWeight: FontWeight.bold,
                  fontSize: selectedFontSize
                  // fontSize: 15
              ),
            ),
          ),
        ),
      ],
    );
  }
}
