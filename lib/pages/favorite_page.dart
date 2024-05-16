import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/card_detail_dokter.dart';
import 'package:konsul_dok/widgets/favorite_dokter_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 94,),
            Text("Favorites", style: MyTextStyle.header,),
            Spacer(),
            Icon(Icons.search),
          ],
        ),
      ),
      body: Padding(padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        children: [
          CardFavoriteDoctor(doctor: "Dr Surata", hospital: "Rumah Sakir Niou ", poli: "Poli Gigi"),
          CardFavoriteDoctor(doctor: "Dr Surata", hospital: "Rumah Sakir Niou ", poli: "Poli Gigi"),
          CardFavoriteDoctor(doctor: "Dr Surata", hospital: "Rumah Sakir Niou ", poli: "Poli Gigi"),
          CardFavoriteDoctor(doctor: "Dr Surata", hospital: "Rumah Sakir Niou ", poli: "Poli Gigi"),
        ],
      ),
      ),
    );
  }
}

