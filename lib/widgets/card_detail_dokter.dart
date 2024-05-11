import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:svg_flutter/svg.dart';

Widget cardDetailDokter() {
  return Container(
    margin: MySpacing.defaultMarginItem,
    padding: MySpacing.padingCard,
    decoration: BoxDecoration(
      color: MyColor.putihForm,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              "Rating",
              style: MyTextStyle.deskripsi.copyWith(color: MyColor.abu),
            ),
            GradientText(
              '4.7',
              style: MyTextStyle.header,
              gradientType: GradientType.linear,
              colors: MyColor.gradientText,
            ),
            RatingBar.builder(
              itemSize: 15,
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
          ],
        ),
        const SizedBox(
          height: 70,
          child: VerticalDivider(
            color: MyColor.abuDivider,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icon/harga_icon.svg',
                ),
                const SizedBox(
                  width: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Harga",
                      style: MyTextStyle.deskripsi.copyWith(
                        color: MyColor.abu,
                      ),
                    ),
                    Text(
                      "Rp150.000",
                      style: MyTextStyle.deskripsi.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icon/pengalaman_icon.svg',
                ),
                const SizedBox(
                  width: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pengalaman",
                      style: MyTextStyle.deskripsi.copyWith(
                        color: MyColor.abu,
                      ),
                    ),
                    Text(
                      "1 Tahun",
                      style: MyTextStyle.deskripsi.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        )
      ],
    ),
  );
}
