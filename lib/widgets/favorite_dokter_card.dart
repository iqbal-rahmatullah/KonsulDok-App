import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class CardFavoriteDoctor extends StatelessWidget {
  final String doctor;
  final String hospital;
  final String poli;
  const CardFavoriteDoctor({super.key, required this.doctor, required this.hospital, required this.poli});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
            // color: MyColor.abu,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: [Color.fromARGB(255, 246, 246, 246), Color.fromARGB(255, 255, 255, 255)]),
            ),
            height: 113,
            width: MediaQuery.of(context).size.width*0.87,
            child:  Row(
              children: [
                SizedBox(width: 20,),
                CircleAvatar(
                  radius: 30, 
                  backgroundColor: MyColor.abu,
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(doctor, style: MyTextStyle.subheder,),
                    Text(poli, style: MyTextStyle.deskripsi,),
                    Text(hospital, style: MyTextStyle.deskripsi,),
                   const  Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber,),
                        Icon(Icons.star, color: Colors.amber,),
                        Icon(Icons.star, color: Colors.amber,),
                        Icon(Icons.star, color: Colors.amber,),
                        Icon(Icons.star, color: Colors.amber,),
                        SizedBox(width: 5,),
                        Text("5")
                      ],
                    )
                  ],
                ),
                const SizedBox(width: 20,),
               const  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.favorite, color: MyColor.biru,),
                    Text("50 ulasan", style: TextStyle(color: Color.fromARGB(155, 144, 144, 144)),)
                  ],
                )
              ],
            ),
          ),
    );
  }
}