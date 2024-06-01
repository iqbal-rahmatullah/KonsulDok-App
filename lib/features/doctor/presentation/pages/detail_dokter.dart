import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/chat_bloc.dart';
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
  const DetailDokter({super.key, required this.id});

  @override
  State<DetailDokter> createState() => _DetailDokterState();
}

class _DetailDokterState extends State<DetailDokter> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DoctorBloc>(context).add(DoctorGetById(id: widget.id));
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
                    if (state is DoctorGetByIdLoaded) {
                      context.read<ChatBloc>().add(GetDetailChatEvent(
                            doctorId: int.parse(widget.id),
                          ));

                      BlocListener<ChatBloc, ChatState>(
                        listener: (context, stateChat) {
                          if (stateChat is ChatDetailLoaded) {
                            context.goNamed('chat_dokter',
                                extra: stateChat.chatDetails,
                                pathParameters: {
                                  'name': state.doctor.kategori,
                                  'id': state.doctor.id.toString(),
                                });
                          } else if (stateChat is ChatError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(stateChat.message)),
                            );
                          }
                        },
                      );
                    }
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
                      if (state is DoctorGetByIdLoaded) {
                        context.goNamed('order',
                            extra: state.doctor,
                            pathParameters: {
                              'name': state.doctor.kategori,
                              'id': state.doctor.id.toString(),
                            });
                      }
                    }),
              ],
            );
          },
        ),
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, stateChat) {
          if (stateChat is ChatDetailLoaded) {
            final doctorState =
                context.read<DoctorBloc>().state as DoctorGetByIdLoaded;

            context.goNamed(
              'chat_dokter',
              extra: stateChat.chatDetails,
              pathParameters: {
                'name': doctorState.doctor.kategori,
                'id': doctorState.doctor.id.toString(),
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
            child: BlocConsumer<DoctorBloc, DoctorState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is DoctorError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is DoctorGetByIdLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        imageDokter(state),
                        titleDokter(state),
                        cardDetailDokter(
                            experience: state.doctor.experience,
                            price: state.doctor.price.toString()),
                        descriptionSection(state),
                        ratingSection(),
                      ],
                    );
                  }
                  return const Center(
                    child: LoadingDetailDokterPage(),
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget imageDokter(DoctorGetByIdLoaded state) {
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
            "${state.doctor.photoProfile}&s=${state.doctor.id}",
          ),
        ),
      ),
    );
  }

  Widget titleDokter(DoctorGetByIdLoaded state) {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.doctor.name,
                style: MyTextStyle.subheder.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Poli ${state.doctor.kategori}",
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
                    state.doctor.hospitalName,
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

  Widget descriptionSection(DoctorGetByIdLoaded state) {
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
            state.doctor.description,
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
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
