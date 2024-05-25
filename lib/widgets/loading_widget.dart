import 'package:flutter/material.dart';

Widget loadingWidget({
  required double width,
  required double height,
  double radius = 0,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: Colors.grey[300],
    ),
  );
}
