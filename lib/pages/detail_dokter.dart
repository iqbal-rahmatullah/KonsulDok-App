import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:konsul_dok/pages/order_page.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/card_detail_dokter.dart';
import 'package:konsul_dok/widgets/card_rating.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:svg_flutter/svg.dart';

class DetailDokter extends StatelessWidget {
  const DetailDokter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail Dokter",
          style: MyTextStyle.subheder.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            myButtonWidget(
              text: "Chat",
              isLarge: false,
              ukuran: MediaQuery.of(context).size.width / 2 - 35,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SizedBox(),
                    ));
              },
            ),
            const SizedBox(
              width: 20,
            ),
            myButtonWidget(
                text: "Buat Janji",
                isLarge: false,
                ukuran: MediaQuery.of(context).size.width / 2 - 35,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPage(),
                      ));
                }),
          ],
        ),
      ),
      body: Container(
        padding: MySpacing.paddingInsetPage,
        child: SingleChildScrollView(
          child: Column(
            children: [
              imageDokter(),
              titleDokter(),
              cardDetailDokter(),
              descriptionSection(),
              ratingSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageDokter() {
    return Container(
      height: 230,
      width: double.infinity,
      margin: MySpacing.defaultMarginItem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          image: AssetImage(
            "assets/images/dokter_banner_example.jpg",
          ),
        ),
      ),
    );
  }

  Widget titleDokter() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dr. Uchiha Santoso",
                style: MyTextStyle.subheder.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Poli Mata",
                    style: MyTextStyle.deskripsi.copyWith(
                      color: MyColor.abu,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    " | ",
                    style: MyTextStyle.deskripsi.copyWith(
                      color: MyColor.abu,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Rumah Sakit Konoha",
                    style: MyTextStyle.deskripsi.copyWith(
                      color: MyColor.abu,
                    ),
                  )
                ],
              )
            ],
          ),
          const Icon(
            Icons.favorite_border_outlined,
            size: 20,
            color: MyColor.abuForm,
          )
        ],
      ),
    );
  }

  Widget descriptionSection() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deskripsi",
            style: MyTextStyle.subheder.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Dr. Uchiha Santoso adalah dokter spesialis mata yang sudah berpengalaman selama 1 tahun. Beliau sudah menangani banyak pasien dengan berbagai keluhan mata. Dr. Uchiha Santoso juga sudah banyak mendapatkan sertifikat dan penghargaan dari berbagai event kesehatan.",
            style: MyTextStyle.deskripsi.copyWith(
              color: MyColor.abu,
            ),
          ),
        ],
      ),
    );
  }

  Widget ratingSection() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ulasan",
                style:
                    MyTextStyle.subheder.copyWith(fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Lihat Semua (10)",
                  style: MyTextStyle.deskripsi.copyWith(
                    color: MyColor.biru,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        
        ],
      ),
    );
  }
}
