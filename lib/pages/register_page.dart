import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/textform_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MySpacing.paddingPage,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [headerComponent(), formComponent()],
        ),
      ),
    );
  }

  Widget headerComponent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.putihForm.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: MySpacing.defaultMarginItem,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Image.asset('assets/images/small_icon.png'),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "KonsulDok",
              style: MyTextStyle.header,
            )
          ],
        ),
      ),
    );
  }

  Widget formComponent() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daftar",
            style: MyTextStyle.header,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Selamat Datang! Silahkan buat akun dengan memasukkan data diri Anda.",
            style: MyTextStyle.deskripsi,
          ),
          const SizedBox(
            height: 20,
          ),
          textFormField(hintText: "MasukkanNama", label: "Nama"),
          const SizedBox(
            height: 10,
          ),
          textFormField(
              hintText: "Masukkan Nomor Telepon", label: "Nomor Telepon"),
          const SizedBox(
            height: 10,
          ),
          textFormField(hintText: "Masukkan Email", label: "Email"),
          const SizedBox(
            height: 10,
          ),
          textFormField(hintText: "Masukkan Nama", label: "Nama"),
          const SizedBox(
            height: 10,
          ),
          textFormField(hintText: "Masukkan Sandi", label: "Sandi"),
          const SizedBox(
            height: 10,
          ),
          textFormField(hintText: "Masukkan Konfirmasi Sandi", label: "Sandi"),
          const SizedBox(
            height: 40,
          ),
          myButtonWidget(
              text: "Daftar",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SizedBox(),
                    ));
              }),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sudah memiliki akun?",
                style: MyTextStyle.deskripsi,
              ),
              TextButton(
                onPressed: () {},
                child: Text("Masuk disini",
                    style: MyTextStyle.deskripsi.copyWith(color: MyColor.biru)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
