import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/card_detail_dokter.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:konsul_dok/widgets/radio_button_jam.dart';

class OrderPage extends StatefulWidget {
  final Doctor doctor;
  const OrderPage({super.key, required this.doctor});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Map formData = {
    "date": DatePickerController(),
    "time": 0,
  };

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
            inputTimeSection(),
            actionChatSection(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MySpacing.paddingPage.copyWith(bottom: 50),
        child: myButtonWidget(
          text: "Buat Janji",
          onTap: () {
            print(formData['time']);
            print(formData['date']);
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
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                widget.doctor.photoProfile,
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
                widget.doctor.name,
                style: MyTextStyle.subheder.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Poli ${widget.doctor.kategori}",
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
                    widget.doctor.hospitalName,
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

  Widget inputTimeSection() {
    return Container(
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
            height: 10,
          ),
          Text(
            "Hari",
            style: MyTextStyle.deskripsi.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DatePicker(
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: MyColor.biru,
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
            daysCount: 7,
            height: 90,
            onDateChange: (date) {},
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Jam",
            style: MyTextStyle.deskripsi.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 50),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      customRadioButton(
                        label: "${index >= 2 ? "" : "0"}${8 + index++}:00",
                        isSelected: index == formData['time'],
                        isDisabled: index == 2,
                        onTap: () {
                          setState(() {
                            formData['time'] = index;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget actionChatSection() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: MyColor.putihForm,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ingin membuat janji di luar jadwal?",
                  style: MyTextStyle.deskripsi,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Chat dokter",
                    style: MyTextStyle.deskripsi.copyWith(
                      color: MyColor.biru,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
