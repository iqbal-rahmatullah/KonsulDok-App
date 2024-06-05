import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/doctor/presentation/pages/poli_page.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget buttonPoliklinik(
    {required String title,
    required String image,
    required BuildContext context}) {
  return Column(
    children: [
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: MyColor.gradientBiru,
        ),
        child: ElevatedButton(
          onPressed: () {
            context.goNamed('poli', pathParameters: {'name': title});
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            shape: const CircleBorder(),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: Image.asset(
            "assets/images/icon_poliklinik/$image",
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
