import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/custom_snackbar.dart';
import 'package:konsul_dok/widgets/text_action.dart';
import 'package:konsul_dok/widgets/textform_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  Map formData = {
    "email": TextEditingController(),
    "password": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            CustomSnackbar.showErrorSnackbar(context, state.message);
          } else if (state is AuthLoginSuccess) {
            context.read<AuthBloc>().add(AuthSaveToken(token: state.message));
          } else if (state is AuthSuccessSaveToken) {
            context.read<AuthBloc>().add(AuthGetUser());
          } else if (state is AuthGetUserSuccess) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              CustomSnackbar.showSuccessSnackbar(
                  context, "Anda berhasil login");
            });
            context.goNamed('home');
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: MySpacing.paddingPage.copyWith(top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    headerComponent(),
                    formComponent(state),
                  ],
                ),
              ),
            ),
          );
        },
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

  Widget formComponent(AuthState state) {
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
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextForm(
                    label: "Email",
                    hintText: "Masukkan email",
                    controller: formData['email'],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextForm(
                    label: "Password",
                    hintText: "Masukkan password",
                    controller: formData['password'],
                    isObsecure: true,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: Text("Lupa Sandi?",
                  //         style: MyTextStyle.deskripsi
                  //             .copyWith(color: MyColor.abuForm)),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  myButtonWidget(
                      text: "Masuk",
                      isLoading: state is AuthLoading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignIn(
                                email: formData['email'].text,
                                password: formData['password'].text,
                              ));
                        }
                      }),
                ],
              )),
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
              const SizedBox(
                width: 5,
              ),
              textAction(
                text: "Daftar disini",
                onTap: () {
                  context.goNamed('register');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
