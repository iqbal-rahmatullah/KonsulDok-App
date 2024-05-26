import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/route.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';

Widget cardDokter({required BuildContext context, required Doctor doctor}) {
  return GestureDetector(
    onTap: () {
      context.goNamed('detail_dokter', pathParameters: {
        'id': doctor.id.toString(),
        "name": doctor.kategori
      });
    },
    child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 0,
        color: MyColor.putihForm.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    doctor.photoProfile,
                  ),
                  radius: 30,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        doctor.name,
                        style: MyTextStyle.subheder,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(
                      Icons.favorite_border_outlined,
                      size: 20,
                      color: MyColor.abuForm,
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.hospitalName,
                      style: MyTextStyle.deskripsi,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            RatingBar.builder(
                              itemSize: 20,
                              initialRating: 4.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ignoreGestures: true,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: MyColor.yellowStar,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "4.7",
                              style: MyTextStyle.deskripsi.copyWith(
                                color: MyColor.abuForm,
                              ),
                            )
                          ],
                        ),
                        Text(
                          "50 Ulasan",
                          style: MyTextStyle.deskripsi
                              .copyWith(color: MyColor.abuText),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              myButtonWidget(
                  text: "Buat janji",
                  onTap: () {
                    context.goNamed('order_from_poli',
                        extra: doctor,
                        pathParameters: {
                          'name': doctor.kategori,
                        });
                  })
            ],
          ),
        )),
  );
}
