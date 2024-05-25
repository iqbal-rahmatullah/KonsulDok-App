import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/radio_button.dart';
import 'package:konsul_dok/widgets/text_action.dart';
import 'package:konsul_dok/widgets/textform_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    "name": TextEditingController(),
    "email": TextEditingController(),
    "password": TextEditingController(),
    "confirm_password": TextEditingController(),
    "no_hp": TextEditingController(),
    "gender": "",
    "age": TextEditingController(),
  };

  @override
  void dispose() {
    formData.forEach((key, value) {
      if (key != "gender") value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MySpacing.paddingPage,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.message,
                    style: MyTextStyle.deskripsi.copyWith(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ));
              } else if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Berhasil mendaftar",
                    style: MyTextStyle.deskripsi.copyWith(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ));
                context.goNamed('login');
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [headerComponent(), formComponent()],
              );
            },
          ),
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
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextForm(
                    hintText: "Masukkan Nama",
                    label: "Nama",
                    controller: formData["name"],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextForm(
                    hintText: "Masukkan Nomor Telepon",
                    label: "Nomor Telepon",
                    controller: formData["no_hp"],
                    isNumberOnly: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RadioButton(
                          gender: formData['gender'],
                          onChanged: (value) {
                            setState(() {
                              formData['gender'] = value;
                            });
                          }),
                      TextForm(
                        hintText: "Umur",
                        label: "Umur",
                        controller: formData["age"],
                        isNumberOnly: true,
                        isSmall: true,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextForm(
                    hintText: "Masukkan Email",
                    label: "Email",
                    controller: formData["email"],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextForm(
                    hintText: "Masukkan Sandi",
                    label: "Sandi",
                    controller: formData["password"],
                    isObsecure: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextForm(
                    hintText: "Masukkan Konfirmasi Sandi",
                    label: "Konfirmasi Sandi",
                    controller: formData["confirm_password"],
                    isObsecure: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myButtonWidget(
                      text: "Daftar",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (formData['password'].text !=
                              formData['confirm_password'].text) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Password tidak sama",
                                style: MyTextStyle.deskripsi
                                    .copyWith(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ));
                            return;
                          }

                          context.read<AuthBloc>().add(AuthSignUp(
                                email: formData['email'].text,
                                password: formData['password'].text,
                                name: formData['name'].text,
                                phone: formData['no_hp'].text,
                                age: int.parse(formData['age'].text),
                                gender: formData['gender'],
                              ));
                        }
                      }),
                ],
              )),
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
              textAction(
                text: "Masuk disini",
                onTap: () {
                  context.goNamed('login');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
