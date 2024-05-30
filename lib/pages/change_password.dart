import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/textform_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Ubah Sandi',
          style: MyTextStyle.header.copyWith(color: MyColor.blackAppbar),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MyColor.blackAppbar),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: MySpacing.paddingPage,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 16.0),
                  TextForm(
                    hintText: "Password lama",
                    label: "Password Lama",
                    controller: _passwordController,
                    isObsecure: true,
                  ),
                  SizedBox(height: 16.0),
                  TextForm(
                    hintText: "Password baru",
                    label: "Password Baru",
                    controller: _newPasswordController,
                    isObsecure: true,
                  ),
                  SizedBox(height: 40.0),
                  myButtonWidget(
                    text: "Simpan Perubahan",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle password change
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
