import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:konsul_dok/features/rating/domain/entities/rating.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/parse_month.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget cardRating({required Rating rating}) {
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
              "${rating.createdAt.day} ${ParseMonth.convert(rating.createdAt.month)}\n${rating.createdAt.year}",
              style: MyTextStyle.deskripsi.copyWith(
                fontSize: 10,
                color: MyColor.abuForm,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              rating.namePatient,
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
              initialRating: double.parse(rating.rating.toString()),
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
              rating.rating.toString(),
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
