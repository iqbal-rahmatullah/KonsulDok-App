import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:konsul_dok/pages/detail_dokter.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';

Widget cardDokter({required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DetailDokter(),
        ),
      );
    },
    child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 0,
        color: MyColor.putihForm.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/doctor-example.jpg",
                  ),
                ),
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dr. Ahmad Muzakki',
                      style: MyTextStyle.subheder,
                    ),
                    Icon(
                      Icons.favorite_border_outlined,
                      size: 20,
                      color: MyColor.abuForm,
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rumah Sakit PEMNS',
                      style: MyTextStyle.deskripsi,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              width: 5,
                            ),
                            Text(
                              "4.7",
                              style: MyTextStyle.deskripsi.copyWith(
                                color: MyColor.abuForm,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "50 Ulasan",
                          style: MyTextStyle.deskripsi
                              .copyWith(color: MyColor.abuText),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              myButtonWidget(text: "Buat janji")
            ],
          ),
        )),
  );
}
