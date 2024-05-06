import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget chatWidget() {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: MyColor.abuForm,
          width: 0.5,
        ),
      ),
    ),
    child: Padding(
      padding: MySpacing.padingCard,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(
              "assets/images/doctor-example.jpg",
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "Dr. Hyuuga Narji",
                      style: MyTextStyle.subheder.copyWith(
                        color: MyColor.hitam,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check,
                          color: MyColor.biruIndicator,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Checkup jam 17.00 dok",
                          style: MyTextStyle.deskripsi
                              .copyWith(color: MyColor.hitam),
                        )
                      ],
                    )
                  ],
                ),
                Text(
                  "07.56",
                  style: MyTextStyle.deskripsi.copyWith(color: MyColor.abuText),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
