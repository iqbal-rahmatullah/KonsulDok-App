import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget buttonPoliklinik({required String title, required String image}) {
  return Column(
    children: [
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle, // shape makes the circular button
          gradient: MyColor.gradientBiru,
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(7),
            shape: const CircleBorder(),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Image.asset(
            "assets/images/icon_poliklinik/${image}",
            width: 25,
          ),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        title,
        textAlign: TextAlign.center,
        style: MyTextStyle.deskripsi,
      )
    ],
  );
}
