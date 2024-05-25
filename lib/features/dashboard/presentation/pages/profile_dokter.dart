import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:konsul_dok/pages/faq_page.dart';
import 'package:konsul_dok/features/dashboard/presentation/pages/home_page.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class ProfileDokter extends StatelessWidget {
  const ProfileDokter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                gradient: MyColor.gradientBiru,
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width * 0.87,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Padding(
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Dr Budi",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'outfit',
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Spesialis Saraf Mata",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'outfit',
                              ),
                            ),
                            Text(
                              "Rumah Sakit Karangmenjangan Suarabaya",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'outfit',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "085646160501",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'outfit',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemSize: 20,
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          )
                        ],
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  MenuProfile(
                    text: "Lihat atau edit Profile",
                    icon: const Icon(Icons.person_2, color: MyColor.biru),
                    destination:
                        PlaceholderPage(), // Ganti dengan halaman yang sesuai
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    color: MyColor.abuForm,
                    thickness: 1,
                  ),
                  const SizedBox(height: 5),
                  MenuProfile(
                    text: "Ubah sandi",
                    icon: const Icon(Icons.lock_outlined, color: MyColor.biru),
                    destination:
                        PlaceholderPage(), // Ganti dengan halaman yang sesuai
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    color: MyColor.abuForm,
                    thickness: 1,
                  ),
                  const SizedBox(height: 5),
                  MenuProfile(
                    text: "FAQ",
                    icon: const Icon(Icons.help_center_outlined,
                        color: MyColor.biru),
                    destination: const SizedBox(),
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    color: MyColor.abuForm,
                    thickness: 1,
                  ),
                  const SizedBox(height: 5),
                  MenuProfile(
                    text: "Keluar",
                    icon: const Icon(Icons.logout, color: MyColor.biru),
                    destination:
                        PlaceholderPage(), // Ganti dengan halaman yang sesuai
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    color: MyColor.abuForm,
                    thickness: 1,
                  ),
                ],
              ),
            ),
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

  const MenuProfile({
    super.key,
    required this.text,
    required this.icon,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 10),
                Text(
                  text,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

// Halaman placeholder untuk menggantikan halaman FavoritePage
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placeholder Page'),
      ),
      body: const Center(
        child: Text('This is a placeholder page. Replace with actual page.'),
      ),
    );
  }
}
