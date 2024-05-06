import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget myButtonWidget({required String text, bool isLarge = true}) {
  return Container(
    width: (isLarge) ? double.infinity : null,
    decoration: BoxDecoration(
      gradient: MyColor.gradientBiru,
      borderRadius: BorderRadius.circular(50),
    ),
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Text(
        text,
        style: MyTextStyle.subheder.copyWith(
          fontWeight: FontWeight.w500,
          color: MyColor.putih,
        ),
      ),
    ),
  );
}
