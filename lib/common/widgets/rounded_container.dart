import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final String title;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? fontColor;
  List<BoxShadow>? boxShadow;
  FontStyle? fontStyle;
  AlignmentGeometry? alignment;
  RoundedContainer(
      {required this.title,
      this.boxShadow,
      this.fontStyle,
      this.width,
      this.alignment = Alignment.centerLeft,
      this.fontColor,
      this.color,
      this.padding = const EdgeInsets.fromLTRB(5, 2, 2, 2),
      this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      alignment: alignment,
      width: width,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        borderRadius: BorderRadius.circular(5),

        color: color,
        // borderRadius: BorderRadius.circular(5),
        // border: Border.all(
        //   color: Colors.black,
        //   width: 2,
        // ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: fontColor,
          fontSize: 13,
          fontStyle: fontStyle,
        ),
      ),
    );
  }
}
