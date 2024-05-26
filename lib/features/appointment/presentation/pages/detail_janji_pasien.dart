import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class DetailJanjiPasien extends StatefulWidget {
  const DetailJanjiPasien({super.key});

  @override
  State<DetailJanjiPasien> createState() => _DetailJanjiPasienState();
}

class _DetailJanjiPasienState extends State<DetailJanjiPasien> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          'Janji Saya',
          style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
        ),
      ),
      body: Column(
        children: [
          cardHome(),
          detailDokter(),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
            child: Divider(
              color: MyColor.abuText,
              thickness: 1,
            ),
          ),
          detailJanji(),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
            child: Divider(
              color: MyColor.abuText,
              thickness: 1,
            ),
          ),
          detailPasien(),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
            child: Divider(
              color: MyColor.abuText,
              thickness: 1,
            ),
          ),
          detailStatus()
        ],
      ),
    );
  }

  Widget cardHome() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      // width: MediaQuery.sizeOf(context).width,
      // height: MediaQuery.sizeOf(context).width,
      children: [
        Center(
          // margin: const EdgeInsets.only(bottom: 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            width: MediaQuery.sizeOf(context).width * 7 / 8,
            decoration: BoxDecoration(
                gradient: MyColor.gradientBiru,
                borderRadius: BorderRadius.circular(20)),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 90,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Rabu,",
                            textAlign: TextAlign.center,
                            style: MyTextStyle.subheder
                                .copyWith(color: MyColor.putih),
                          ),
                          Text(
                            "01 Mei 2024",
                            textAlign: TextAlign.center,
                            style:
                                MyTextStyle.name.copyWith(color: MyColor.putih),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "08.00",
                            textAlign: TextAlign.center,
                            style:
                                MyTextStyle.name.copyWith(color: MyColor.putih),
                          )
                        ],
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 2,
                    color: MyColor.putih,
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Dr. Abireya Nur Zidan",
                            style:
                                MyTextStyle.name.copyWith(color: MyColor.putih),
                          ),
                          Text(
                            "Poli Bedah Dalam",
                            style: MyTextStyle.subheder
                                .copyWith(color: MyColor.putih),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "RS PEMNS",
                            style:
                                MyTextStyle.name.copyWith(color: MyColor.putih),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget rowDescript(String label, String isi) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              textAlign: TextAlign.left,
              style: MyTextStyle.deskripsi.copyWith(color: MyColor.blackAppbar),
            ),
            Text(
              isi,
              textAlign: TextAlign.left,
              style: MyTextStyle.deskripsi.copyWith(color: MyColor.blackAppbar),
            ),
          ],
        ),
      ],
    );
  }

  Widget detailDokter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: MediaQuery.sizeOf(context).width * 7 / 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Dokter',
            textAlign: TextAlign.left,
            style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
          ),
          rowDescript("Nama dokter", "Dr. Abireya Nur Zidan"),
          rowDescript("Poliklinik", "Poli Bedah Dalam"),
          rowDescript("Rumah sakit", "RS PEMNS"),
          rowDescript("Lokasi", "Sukolilo, Surabaya"),
        ],
      ),
    );
  }

  Widget detailJanji() {
    return SizedBox(
      // padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: MediaQuery.sizeOf(context).width * 7 / 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Janji',
            textAlign: TextAlign.left,
            style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
          ),
          rowDescript("Tanggal", "Rabu, 01 Mei 2024"),
          rowDescript("Jam", "08.00"),
        ],
      ),
    );
  }

  Widget detailPasien() {
    return SizedBox(
      // padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: MediaQuery.sizeOf(context).width * 7 / 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Pasien',
            textAlign: TextAlign.left,
            style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
          ),
          rowDescript("Nama pasien", "Gendra Padmawan"),
          rowDescript("Jenis kelamin", "Laki-laki"),
          rowDescript("Usia", "68 tahun"),
        ],
      ),
    );
  }

  Widget detailStatus() {
    return SizedBox(
      // padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: MediaQuery.sizeOf(context).width * 7 / 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status',
            textAlign: TextAlign.left,
            style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
          ),
          rowDescript("Status", "Disetujui"),
        ],
      ),
    );
  }
}
