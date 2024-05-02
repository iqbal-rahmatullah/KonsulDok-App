import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_poliklinik.dart';
import 'package:konsul_dok/widgets/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MySpacing.paddingPage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          topBar(),
          searchInput(),
          menuPoliklinik(),
          riwayatJanji(),
        ],
      ),
    );
  }

  Widget topBar() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/images/small_icon.png'),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Halo",
                style: MyTextStyle.subheder
                    .copyWith(fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                width: 5,
              ),
              Text("Abireya",
                  style: MyTextStyle.subheder.copyWith(
                    fontWeight: FontWeight.w800,
                  )),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_active,
              color: MyColor.biru,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchInput() {
    return Container(margin: MySpacing.defaultMarginItem, child: textField());
  }

  Widget menuPoliklinik() {
    const polikliknik = [
      {
        "name": "Poli Umum",
        "image": "poli_umum.png",
      },
      {
        "name": "Poli Gigi",
        "image": "poli_gigi.png",
      },
      {
        "name": "Poli Mata",
        "image": "poli_mata.png",
      },
      {
        "name": "Poli Anak",
        "image": "poli_anak.png",
      },
      {
        "name": "Poli Kandungan",
        "image": "poli_kandungan.png",
      },
      {
        "name": "Poli Penyakit Dalam",
        "image": "poli_penyakit_dalam.png",
      },
      {
        "name": "Poli Jantung",
        "image": "poli_jantung.png",
      },
      {
        "name": "Poli Bedah",
        "image": "poli_bedah.png",
      },
    ];

    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Poliklinik",
                style: MyTextStyle.subheder,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Lihat Semua",
                  style: MyTextStyle.deskripsi.copyWith(
                    color: MyColor.biru,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          GridView.count(
            padding: EdgeInsets.zero,
            crossAxisCount: 4,
            shrinkWrap: true,
            children: List.generate(8, (index) {
              return buttonPoliklinik(
                  title: polikliknik[index]['name']!,
                  image: polikliknik[index]['image']!);
            }),
          ),
        ],
      ),
    );
  }

  Widget riwayatJanji() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Riwayat jadwal janji",
                style: MyTextStyle.subheder,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Lihat Semua",
                  style: MyTextStyle.deskripsi.copyWith(
                    color: MyColor.biru,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyColor.putihForm,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Column(
                children: [
                  Image.asset('assets/images/empty_janji.png'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Anda belum memiliki jadwal janji dengan dokter.",
                    style: MyTextStyle.deskripsi.copyWith(
                      color: MyColor.abuForm,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
