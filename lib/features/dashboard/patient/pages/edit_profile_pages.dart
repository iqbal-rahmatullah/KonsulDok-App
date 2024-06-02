import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/custom_snackbar.dart';
import 'package:konsul_dok/widgets/radio_button.dart';
import 'package:konsul_dok/widgets/textform_field.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> formData;

  @override
  void dispose() {
    formData.forEach((key, value) {
      if (key != "gender") value.dispose();
    });
    super.dispose();
  }

  @override
  void initState() {
    formData = {
      "name": TextEditingController(text: widget.user.name),
      "email": TextEditingController(text: widget.user.email),
      "no_hp": TextEditingController(text: widget.user.phone),
      "gender": widget.user.gender,
      "age": TextEditingController(text: widget.user.age.toString()),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthEditProfileFailed) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            CustomSnackbar.showErrorSnackbar(context, state.message);
          });
        } else if (state is AuthGetUserSuccess) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            CustomSnackbar.showSuccessSnackbar(
                context, "Anda berhasil mengubah profile.");
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Edit profile',
              style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: MySpacing.paddingPage.copyWith(top: 20),
              child: formSection(),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: MySpacing.paddingPage.copyWith(top: 0, bottom: 20),
            child: myButtonWidget(
                text: "Simpan perubahan",
                isLoading: state is AuthLoading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          AuthEditProfileEvent(
                              age: int.parse(formData['age'].text),
                              email: formData['email'].text,
                              gender: formData['gender'],
                              name: formData['name'].text,
                              phone: formData['no_hp'].text),
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
          TextForm(
            hintText: "Masukkan Email",
            label: "Email",
            controller: formData["email"],
          ),
          const SizedBox(
            height: 10,
          ),
          RadioButton(
              gender: formData['gender'],
              onChanged: (value) {
                setState(() {
                  formData['gender'] = value;
                });
              }),
          const SizedBox(
            height: 10,
          ),
          TextForm(
            hintText: "Umur",
            label: "Umur",
            controller: formData["age"],
            isNumberOnly: true,
          ),
        ],
      ),
    );
  }
}
