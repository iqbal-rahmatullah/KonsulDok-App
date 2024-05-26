import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget cardDetailSuccesOrder(
    {required String title,
    required String value,
    required String icon,
    bool isSmall = false}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: isSmall
        ? const EdgeInsets.only(top: 7, bottom: 7, left: 15, right: 50)
        : MySpacing.paddingMiniCard,
    decoration: BoxDecoration(
      color: const Color(0xffF6F6F6),
      borderRadius: BorderRadius.circular(50),
    ),
    child: Row(
      children: [
        Image.asset(
          'assets/images/success_order/$icon',
          width: 30,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: MyTextStyle.deskripsi,
            ),
            Text(
              value,
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
