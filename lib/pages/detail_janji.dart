import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class DetailJanjiPage extends StatelessWidget {
  const DetailJanjiPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Janji Saya',
          style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColor.blackAppbar),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Container(
                width: 350,
                height: 130,
                decoration: BoxDecoration(
                  gradient: MyColor.gradientBiru,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Rabu',
                                style: MyTextStyle.subheder.copyWith(color: MyColor.putihForm),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Center(
                              child: Text(
                                '01 Mei 2024',
                                style: MyTextStyle.subheder.copyWith(color: MyColor.putihForm),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                '+628123456789',
                                style: MyTextStyle.subheder.copyWith(color: MyColor.putihForm),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 1,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Budi Mulyono',
                              style: MyTextStyle.subheder.copyWith(color: MyColor.putihForm),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Laki-Laki',
                              style: MyTextStyle.subheder.copyWith(color: MyColor.putihForm),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                for (int i = 0; i < 5; i++)
                                  i < 4 
                                      ? Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.star_half,
                                          color: Colors.yellow,
                                          size: 20,
                                        ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Dokter',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nama Dokter',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Poliklinik',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rumah Sakit',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lokasi ',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
