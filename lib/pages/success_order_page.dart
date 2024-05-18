import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/card_detail_success_order.dart';

class SuccesOrderPage extends StatelessWidget {
  const SuccesOrderPage({super.key});

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
            headerSection(),
            detailOrderSection(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MySpacing.paddingPage.copyWith(bottom: 50),
        child: myButtonWidget(
          text: "Lihat Detail",
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

  Widget headerSection() {
    return Container(
      margin: MySpacing.defaultMarginItem.copyWith(bottom: 50),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/success_icon.png",
              width: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.center,
              "Sukses Membuat Janji !",
              style: MyTextStyle.subheder.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              textAlign: TextAlign.center,
              "Anda telah berhasil membuat janji dengan \nDr. Uchiha Santoso",
              style: MyTextStyle.deskripsi,
            )
          ],
        ),
      ),
    );
  }

  Widget detailOrderSection() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        children: [
          cardDetailSuccesOrder(),
          cardDetailSuccesOrder(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardDetailSuccesOrder(),
              cardDetailSuccesOrder(),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "*Catatan : Pembayaran dilakukan secara tunai setelah melakukan konsultasi dengan dokter.",
            textAlign: TextAlign.center,
            style: MyTextStyle.deskripsi.copyWith(
              color: MyColor.abuForm,
            ),
          ),
        ],
      ),
    );
  }
}
