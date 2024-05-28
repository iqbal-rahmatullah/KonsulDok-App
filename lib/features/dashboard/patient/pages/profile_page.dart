import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/pages/faq_page.dart';
import 'package:konsul_dok/pages/favorite_page.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state as AuthGetUserSuccess;

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          authState.user.name,
                          style: MyTextStyle.name.copyWith(color: Colors.white),
                        ),
                        Text(
                          authState.user.phone,
                          style: MyTextStyle.deskripsi
                              .copyWith(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                children: [
                  MenuProfile(
                    text: "Edit Profile",
                    icon: Icon(
                      Icons.person_2,
                      color: MyColor.biru,
                    ),
                    destination: FavoritePage(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: MyColor.abuDivider,
                    thickness: 1,
                    height: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MenuProfile(
                    text: "Favorit",
                    icon: Icon(
                      Icons.favorite,
                      color: MyColor.biru,
                    ),
                    destination: FavoritePage(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: MyColor.abuDivider,
                    thickness: 1,
                    height: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MenuProfile(
                    text: "Ubah sandi",
                    icon: Icon(
                      Icons.lock_outlined,
                      color: MyColor.biru,
                    ),
                    destination: FavoritePage(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: MyColor.abuDivider,
                    thickness: 1,
                    height: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MenuProfile(
                    text: "Tanya Jawab",
                    icon: Icon(
                      Icons.help_center_outlined,
                      color: MyColor.biru,
                    ),
                    destination: FaqPage(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: MyColor.abuDivider,
                    thickness: 1,
                    height: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MenuProfile(
                    text: "Keluar",
                    icon: Icon(
                      Icons.logout,
                      color: MyColor.biru,
                    ),
                    destination: FavoritePage(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MenuProfile extends StatelessWidget {
  final String text;
  final Icon icon;
  final Widget destination;
  const MenuProfile(
      {super.key,
      required this.text,
      required this.icon,
      required this.destination});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => destination));
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
