import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/pages/faq_page.dart';
import 'package:konsul_dok/pages/favorite_page.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: MyTextStyle.header,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
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
                          "Abdul Manab",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'outfit',
                              fontSize: 18),
                        ),
                        Text(
                          "0898-7865-1342",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'outfit'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                children: [
                  MenuProfile(text: "Lihat atau edit Profile", icon: Icon(Icons.person_2, color: MyColor.biru,), destination: FavoritePage(),),
                  SizedBox(height: 15,),
                  Divider(
                    color: MyColor.abuDivider,
                    thickness: 1,
                    height: 15,
                  ),
                  SizedBox(height: 5,),
                  MenuProfile(text: "Favorite", icon: Icon(Icons.favorite, color: MyColor.biru,), destination: FavoritePage(),),
                  SizedBox(height: 15,),
                  Divider(
                    color: MyColor.abuDivider,
                    thickness: 1,
                    height: 15,
                  ),
                  SizedBox(height: 5,),
                  MenuProfile(text: "Ubah sandi", icon: Icon(Icons.lock_outlined, color: MyColor.biru,), destination: FavoritePage(),),
                  SizedBox(height: 15,),
                  Divider(
                    color: MyColor.abuDivider,
                    thickness: 1,
                    height: 15,
                  ),
                  SizedBox(height: 5,),
                  MenuProfile(text: "Bantuan",icon: Icon(Icons.help_center_outlined, color: MyColor.biru,),destination: FaqPage(),),
                  SizedBox(height: 15,),
                  Divider(
                    color: MyColor.abuDivider,
                    thickness: 1,
                    height: 15,
                  ),
                  SizedBox(height: 5,),
                  MenuProfile(text: "Logout", icon: Icon(Icons.logout, color: MyColor.biru,), destination: FavoritePage(),),
                  SizedBox(height: 15,),
                  Divider(
                    color: MyColor.abuDivider,
                    thickness: 1,
                    height: 15,
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
  const MenuProfile({super.key, required this.text, required this.icon, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon,
            SizedBox(
              width: 4,
            ),
            SizedBox(width: 5,),
            Text(
              text,
              style:TextStyle(fontSize: 15),
            )
          ],
        ),
        InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>destination));
          },
          child: Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }
}
