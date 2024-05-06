import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';

Widget cardTransaction({bool isOrdered = false}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Card(
        color: MyColor.putih,
        margin: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: MySpacing.padingCard,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rabu, 5 Maret 2023",
                    style: MyTextStyle.deskripsi.copyWith(color: MyColor.abu),
                  ),
                  Text(
                    "08.00 WIB",
                    style: MyTextStyle.deskripsi.copyWith(color: MyColor.abu),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/doctor-example.jpg",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. Ahmad Muzakki",
                        style: MyTextStyle.subheder.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Poli Kandungan",
                        style:
                            MyTextStyle.deskripsi.copyWith(color: MyColor.abu),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: MyColor.biruIndicator,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Rumah Sakit PEMNS",
                            style: MyTextStyle.deskripsi
                                .copyWith(color: MyColor.abu),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              (isOrdered)
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            myButtonWidget(
                              text: "Jadwal Lagi",
                              isLarge: false,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            myButtonWidget(
                              text: "Tambah Ulasan",
                              isLarge: false,
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    ],
  );
}
