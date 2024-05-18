import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget cardRating() {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: MySpacing.padingCard,
    decoration: BoxDecoration(
      color: MyColor.putihForm,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "03 Apr\n2024",
              style: MyTextStyle.deskripsi.copyWith(
                fontSize: 10,
                color: MyColor.abuForm,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Intan Srikaya",
              style: MyTextStyle.subheder.copyWith(
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        Row(
          children: [
            RatingBar.builder(
              itemSize: 20,
              initialRating: 4.5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ignoreGestures: true,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: MyColor.yellowStar,
              ),
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              "4.7",
              style: MyTextStyle.deskripsi.copyWith(
                fontWeight: FontWeight.bold,
                color: MyColor.abuForm,
              ),
            )
          ],
        )
      ],
    ),
  );
}
