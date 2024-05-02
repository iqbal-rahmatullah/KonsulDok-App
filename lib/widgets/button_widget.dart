import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget myButtonWidget() {
  return Container(
    width: double.infinity,
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
        "Masuk",
        style: MyTextStyle.subheder.copyWith(
          fontWeight: FontWeight.w500,
          color: MyColor.putih,
        ),
      ),
    ),
  );
}
