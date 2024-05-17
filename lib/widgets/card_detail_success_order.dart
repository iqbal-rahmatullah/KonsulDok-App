import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget cardDetailSuccesOrder() {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: MySpacing.paddingMiniCard,
    decoration: BoxDecoration(
      color: Color(0xffF6F6F6),
      borderRadius: BorderRadius.circular(50),
    ),
    child: Row(
      children: [
        Image.asset(
          'assets/images/success_order/pasien_icon.png',
          width: 30,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nama pasien",
              style: MyTextStyle.deskripsi,
            ),
            Text(
              "Utakata Aitakata",
              style: MyTextStyle.deskripsi.copyWith(
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )
      ],
    ),
  );
}
