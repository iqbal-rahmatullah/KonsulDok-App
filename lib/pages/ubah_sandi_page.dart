import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/custom_snackbar.dart';
import 'package:konsul_dok/widgets/textform_field.dart';

class UbahSandiPage extends StatefulWidget {
  const UbahSandiPage({super.key});

  @override
  State<UbahSandiPage> createState() => _UbahSandiPageState();
}

class _UbahSandiPageState extends State<UbahSandiPage> {
  final _formKey = GlobalKey<FormState>();
  Map formData = {
    "lastPassword": TextEditingController(),
    "newPassword": TextEditingController(),
    "confirmPassword": TextEditingController(),
  };

  @override
  void dispose() {
    formData['lastPassword'].dispose();
    formData['newPassword'].dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthChangePasswordFailed) {
          CustomSnackbar.showErrorSnackbar(context, state.message);
        } else if (state is AuthChangePasswordSucces) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            CustomSnackbar.showSuccessSnackbar(
                context, "Anda berhasil mengganti password.");
          });
          context.read<AuthBloc>().add(AuthGetUser());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Ubah Sandi',
              style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: MySpacing.paddingPage.copyWith(top: 30),
            child: formSection(),
          ),
          bottomNavigationBar: Padding(
            padding: MySpacing.paddingPage.copyWith(top: 0, bottom: 50),
            child: myButtonWidget(
                text: "Simpan perubahan",
                isLoading: state is AuthLoading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (formData['newPassword'].text !=
                        formData['confirmPassword'].text) {
                      CustomSnackbar.showErrorSnackbar(context,
                          "Password baru yang anda masukkan tidak sama");
                      return;
                    }

                    context.read<AuthBloc>().add(
                          AuthChangePasswordEvent(
                              oldPassword: formData['lastPassword'].text,
                              newPassword: formData['newPassword'].text),
                        );
                  }
                }),
          ),
        );
      },
    );
  }

  Widget formSection() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextForm(
              label: "Password Lama",
              hintText: "Masukkan password lama",
              controller: formData['lastPassword'],
              isObsecure: true,
            ),
            const SizedBox(
              height: 10,
            ),
            TextForm(
              label: "Password Baru",
              hintText: "Masukkan password baru",
              controller: formData['newPassword'],
              isObsecure: true,
            ),
            const SizedBox(
              height: 15,
            ),
            TextForm(
              label: "Konfirmasi Password Baru",
              hintText: "Masukkan password baru",
              controller: formData['confirmPassword'],
              isObsecure: true,
            ),
          ],
        ));
  }
}
