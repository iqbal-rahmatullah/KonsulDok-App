// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:konsul_dok/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:konsul_dok/features/doctor/presentation/pages/loading/loading_detail_dokter_page.dart';
import 'package:konsul_dok/features/rating/presentation/bloc/rating_bloc.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/card_detail_dokter.dart';
import 'package:konsul_dok/widgets/card_rating.dart';
import 'package:konsul_dok/widgets/text_action.dart';

class DetailDokter extends StatefulWidget {
  final String id;
  final Doctor doctor;
  const DetailDokter({
    Key? key,
    required this.id,
    required this.doctor,
  }) : super(key: key);

  @override
  State<DetailDokter> createState() => _DetailDokterState();
}

class _DetailDokterState extends State<DetailDokter> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RatingBloc>(context).add(GetRatingByDoctorEvent(widget.id));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail Dokter",
          style: MyTextStyle.subheder.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: BlocBuilder<DoctorBloc, DoctorState>(
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                myButtonWidget(
                  text: "Chat",
                  isLarge: false,
                  ukuran: MediaQuery.of(context).size.width / 2 - 35,
                  onTap: () {
                    context.read<ChatBloc>().add(GetDetailChatEvent(
                          doctorId: int.parse(widget.doctor.id.toString()),
                        ));
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                myButtonWidget(
                    text: "Buat Janji",
                    isLarge: false,
                    ukuran: MediaQuery.of(context).size.width / 2 - 35,
                    onTap: () {
                      context.goNamed('order', extra: {
                        'doctor': widget.doctor,
                      }, pathParameters: {
                        'name': widget.doctor.kategori,
                        'id': widget.doctor.id.toString(),
                      });
                    }),
              ],
            );
          },
        ),
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, stateChat) {
          if (stateChat is ChatDetailLoaded) {
            context.goNamed(
              'chat_dokter',
              extra: {
                'doctor': widget.doctor,
                'chats': stateChat.chatDetails,
              },
              pathParameters: {
                'name': widget.doctor.kategori,
                'id': widget.doctor.id.toString(),
                'name_dokter': widget.doctor.name,
              },
            );
          } else if (stateChat is ChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(stateChat.message)),
            );
          }
        },
        child: Container(
          padding: MySpacing.paddingInsetPage,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageDokter(widget.doctor),
              titleDokter(widget.doctor),
              cardDetailDokter(
                experience: widget.doctor.experience,
                price: widget.doctor.price.toString(),
              ),
              descriptionSection(widget.doctor),
              ratingSection(),
            ],
          )),
        ),
      ),
    );
  }

  Widget imageDokter(Doctor state) {
    return Container(
      height: 230,
      width: double.infinity,
      margin: MySpacing.defaultMarginItem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          image: NetworkImage(
            "${state.photoProfile}&s=${state.id}",
          ),
        ),
      ),
    );
  }

  Widget titleDokter(Doctor state) {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.name,
                style: MyTextStyle.subheder.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Poli ${state.kategori}",
                    style: MyTextStyle.deskripsi.copyWith(
                      color: MyColor.abu,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    " | ",
                    style: MyTextStyle.deskripsi.copyWith(
                      color: MyColor.abu,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    state.hospitalName,
                    style: MyTextStyle.deskripsi.copyWith(
                      color: MyColor.abu,
                    ),
                  )
                ],
              )
            ],
          ),
          const Icon(
            Icons.favorite_border_outlined,
            size: 20,
            color: MyColor.abuForm,
          )
        ],
      ),
    );
  }

  Widget descriptionSection(Doctor state) {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deskripsi",
            style: MyTextStyle.subheder.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            state.description,
            style: MyTextStyle.deskripsi.copyWith(
              color: MyColor.abu,
            ),
          ),
        ],
      ),
    );
  }

  Widget ratingSection() {
    return BlocBuilder<RatingBloc, RatingState>(
      builder: (context, state) {
        if (state is RatingError) {
          return Text(state.message);
        } else if (state is RatingLoaded) {
          return Container(
            margin: MySpacing.defaultMarginItem,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ulasan",
                    style: MyTextStyle.subheder
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  (state.ratings.length <= 3)
                      ? const SizedBox()
                      : textAction(onTap: () {}, text: "Lihat Semua (10)")
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              (state.ratings.isEmpty)
                  ? const SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(
                          "Belum ada rating dari dokter ini",
                          style: MyTextStyle.deskripsi,
                        ),
                      ),
                    )
                  : Column(
                      children: List.generate(state.ratings.length, (index) {
                        return cardRating(rating: state.ratings[index]);
                      }),
                    )
            ]),
          );
        }
        return const LoadingDetailDokterPage();
      },
    );
  }
}
