import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget myButtonWidget({
  required String text,
  bool isLarge = true,
  double? ukuran,
  required Function onTap,
  Color? color,
}) {
  return Container(
    width: (isLarge) ? double.infinity : ukuran,
    height: 45,
    decoration: BoxDecoration(
      gradient: color == null ? MyColor.gradientBiru : null,
      borderRadius: BorderRadius.circular(50),
      color: color,
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        text,
        style: MyTextStyle.subheder.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: isLarge ? 14 : 13,
          color: MyColor.putih,
        ),
      ),
    ),
  );
}
