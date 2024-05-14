import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/card_detail_dokter.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:konsul_dok/widgets/radio_button_jam.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Buat Janji",
          style: MyTextStyle.subheder.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: MySpacing.paddingInsetPage,
        child: Column(
          children: [
            headerProfileDokter(),
            cardDetailDokter(),
            Container(
              margin: MySpacing.defaultMarginItem,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Atur Jadwal",
                    style: MyTextStyle.subheder.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.black,
                    selectedTextColor: Colors.white,
                    monthTextStyle: MyTextStyle.deskripsi.copyWith(
                      fontSize: 8,
                    ),
                    dateTextStyle: MyTextStyle.subheder.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    dayTextStyle: MyTextStyle.deskripsi.copyWith(
                      fontSize: 8,
                      color: const Color(0xff4C4242),
                    ),
                    locale: 'id',
                    daysCount: 10,
                    height: 90,
                    onDateChange: (date) {},
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      customRadioButton(
                          label: "08.00", isSelected: true, onTap: () {}),
                      SizedBox(
                        width: 5,
                      ),
                      customRadioButton(
                          label: "09.00", isSelected: false, onTap: () {})
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MySpacing.paddingPage.copyWith(bottom: 20),
        child: myButtonWidget(
          text: "Simpan",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SizedBox(),
                ));
          },
        ),
      ),
    );
  }

  Widget headerProfileDokter() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        children: [
          Stack(children: [
            const CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(
                "assets/images/doctor-example.jpg",
              ),
            ),
            // Positioned(
            //     bottom: 0,
            //     right: -25,
            //     child: ),
          ]),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dr. Budi Wiranto",
                style: MyTextStyle.subheder.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Poli Umum",
                style: MyTextStyle.deskripsi.copyWith(
                  color: MyColor.abuTextDescription,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: MyColor.biruIndicator,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    "RSUD dr Soetomo, Surabaya",
                    style: MyTextStyle.deskripsi.copyWith(color: MyColor.abu),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
