import 'package:flutter/material.dart';

class CustomIconButtom extends StatelessWidget {
  const CustomIconButtom({
    super.key, 
    required this.onPressed, 
    required this.padding, 
    required this.fontColor, 
    required this.backgroundColor, 
    required this.size, 
    required this.fontSize, 
    required this.icon
  });

  final void Function() onPressed;
  final double padding;
  final Color fontColor;
  final Color backgroundColor;
  final double size;
  final double fontSize;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: padding,
        bottom: padding
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle
      ),
      child: IconButton(
        onPressed: onPressed,
        color: backgroundColor,
          alignment: Alignment.center,
          iconSize: size,
        icon: icon
      ),
    );
  }
}