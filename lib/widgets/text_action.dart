import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget textAction({required Function onTap, required String text}) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child:
        Text(text, style: MyTextStyle.deskripsi.copyWith(color: MyColor.biru)),
  );
}
