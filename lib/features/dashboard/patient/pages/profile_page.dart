import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/features/dashboard/patient/pages/faq_page.dart';
import 'package:konsul_dok/pages/favorite_page.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/custom_snackbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogoutSuccess) {
          context.goNamed('login');
          SchedulerBinding.instance.addPostFrameCallback((_) {
            CustomSnackbar.showSuccessSnackbar(context, "Anda berhasil logout");
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Profile',
              style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
            ),
          ),
          body: Container(
            padding: MySpacing.paddingInsetPage,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: MyColor.gradientBiru,
                        borderRadius: BorderRadius.circular(20)),
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: 87,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person_outline,
                              color: MyColor.biru,
                              size: 30,
                            ),
                          ),
                        ),
                        if (state is AuthGetUserSuccess)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.user.name,
                                style: MyTextStyle.name
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                state.user.phone,
                                style: MyTextStyle.deskripsi
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Column(
                    children: [
                      MenuProfile(
                        text: "Edit Profile",
                        icon: const Icon(
                          Icons.person_2,
                          color: MyColor.biru,
                        ),
                        onTap: () {
                          context.goNamed('edit_profile',
                              extra: state is AuthGetUserSuccess
                                  ? state.user
                                  : null);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: MyColor.abuDivider,
                        thickness: 1,
                        height: 15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MenuProfile(
                        text: "Favorit",
                        icon: const Icon(
                          Icons.favorite,
                          color: MyColor.biru,
                        ),
                        onTap: () {
                          const FavoritePage();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: MyColor.abuDivider,
                        thickness: 1,
                        height: 15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MenuProfile(
                        text: "Ubah sandi",
                        icon: const Icon(
                          Icons.lock_outlined,
                          color: MyColor.biru,
                        ),
                        onTap: () {
                          context.goNamed('change_password');
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: MyColor.abuDivider,
                        thickness: 1,
                        height: 15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MenuProfile(
                        text: "Tanya Jawab",
                        icon: const Icon(
                          Icons.help_center_outlined,
                          color: MyColor.biru,
                        ),
                        onTap: () {
                          context.goNamed('faq');
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        color: MyColor.abuDivider,
                        thickness: 1,
                        height: 15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      MenuProfile(
                        text: "Keluar",
                        icon: const Icon(
                          Icons.logout,
                          color: MyColor.biru,
                        ),
                        onTap: () {
                          context.read<AuthBloc>().add(AuthLogout());
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class MenuProfile extends StatelessWidget {
  final String text;
  final Icon icon;
  final void Function() onTap;
  const MenuProfile(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(
                width: 4,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                text,
                style:
                    MyTextStyle.subheder.copyWith(fontWeight: FontWeight.w400),
              )
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
          )
        ],
      ),
    );
  }
}
