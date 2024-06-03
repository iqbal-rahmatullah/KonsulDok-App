import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/success_order/success_order_args.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/card_detail_success_order.dart';

class SuccesOrderPage extends StatelessWidget {
  final SuccessOrderArgs args;

  const SuccesOrderPage({super.key, required this.args});

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
          text: "Kembali ke Beranda",
          onTap: () {
            context.goNamed('home');
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
            const SizedBox(
              height: 10,
            ),
            Text(
              textAlign: TextAlign.center,
              "Anda telah berhasil membuat janji dengan \n${args.doctor.name}",
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
          cardDetailSuccesOrder(
              icon: "pasien_icon.png",
              title: "Nama Pasien",
              value: args.user.name),
          cardDetailSuccesOrder(
              icon: "harga_icon.png",
              title: "Harga",
              value: "Rp. ${args.doctor.price}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cardDetailSuccesOrder(
                  icon: "tanggal_icon.png",
                  title: "Tanggal",
                  value: args.appointment.date,
                  isSmall: true),
              cardDetailSuccesOrder(
                  icon: "jam_icon.png",
                  title: "Jam",
                  value: "${args.appointment.time} WIB",
                  isSmall: true),
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
