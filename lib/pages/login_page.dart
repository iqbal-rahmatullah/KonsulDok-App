import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/textform_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MySpacing.paddingPage,
        child: Column(
          children: [
            headerComponent(),
            formComponent(),
          ],
        ),
      ),
    );
  }

  Widget headerComponent() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.putihForm.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: MySpacing.defaultMarginItem,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/large_icon.png'),
            const SizedBox(
              height: 10,
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
      width: double.infinity,
      margin: MySpacing.defaultMarginItem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Login",
            style: MyTextStyle.header,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Selamat Datang! Silahkan masuk ke akun Anda.",
            style: MyTextStyle.deskripsi,
          ),
          const SizedBox(
            height: 30,
          ),
          textFormField(label: "Email", hintText: "Masukkan email"),
          const SizedBox(
            height: 10,
          ),
          textFormField(label: "Password", hintText: "Masukkan password"),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text("Lupa Sandi?",
                  style:
                      MyTextStyle.deskripsi.copyWith(color: MyColor.abuForm)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          myButtonWidget(
              text: "Masuk",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SizedBox(),
                    ));
              }),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Belum punya akun?",
                style: MyTextStyle.deskripsi,
              ),
              TextButton(
                onPressed: () {},
                child: Text("Daftar disini",
                    style: MyTextStyle.deskripsi.copyWith(color: MyColor.biru)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
