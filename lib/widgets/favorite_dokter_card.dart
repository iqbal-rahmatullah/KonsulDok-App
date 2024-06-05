import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/favorite/presentation/bloc/delete_favorite/delete_favorite_bloc.dart';
import 'package:konsul_dok/features/favorite/presentation/bloc/get_favorite/get_favorite_bloc.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class CardFavoriteDoctor extends StatelessWidget {
  final Doctor doctor;
  final int idFavorite;
  const CardFavoriteDoctor({
    super.key,
    required this.doctor,
    required this.idFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteFavoriteBloc, DeleteFavoriteState>(
      listener: (context, state) {
        if (state is DeleteFavoriteSuccess) {
          context.read<GetFavoriteBloc>().add(OnGetFavorite());
        } else if (state is DeleteFavoriteError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
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
                      "${doctor.photoProfile}&s=${doctor.id}",
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
                      InkWell(
                        onTap: () {
                          context
                              .read<DeleteFavoriteBloc>()
                              .add(OnDeleteFavorite(doctor.id));
                        },
                        borderRadius: BorderRadius.circular(50),
                        splashColor: Colors.grey.withOpacity(0.2),
                        highlightColor: Colors.grey.withOpacity(0.1),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.favorite,
                            size: 20,
                            color: MyColor.biruIndicator,
                          ),
                        ),
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
                                initialRating:
                                    doctor.averageRating?.toDouble() ?? 0,
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
                                doctor.averageRating?.toString() ?? "0",
                                style: MyTextStyle.deskripsi.copyWith(
                                  color: MyColor.abuForm,
                                ),
                              )
                            ],
                          ),
                          Text(
                            "${doctor.totalRating} Ulasan",
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
              ],
            ),
          )),
    );
  }
}
