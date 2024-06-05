// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/chat/domain/usecase/open_chat.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/get_chat_doctor/get_chat_doctor_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/open_chat/open_chat_bloc.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:konsul_dok/features/doctor/presentation/pages/loading/loading_detail_dokter_page.dart';
import 'package:konsul_dok/features/favorite/presentation/bloc/add_favorite/add_favorite_bloc.dart';
import 'package:konsul_dok/features/favorite/presentation/bloc/check_favorite/check_favorite_bloc.dart';
import 'package:konsul_dok/features/favorite/presentation/bloc/delete_favorite/delete_favorite_bloc.dart';
import 'package:konsul_dok/features/favorite/presentation/bloc/get_favorite/get_favorite_bloc.dart';
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
  void initState() {
    context
        .read<CheckFavoriteBloc>()
        .add(OnCheckFavorite(doctorId: widget.doctor.id));
    super.initState();
  }

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
                    context.read<GetChatDoctorBloc>().add(
                          GetChatDoctorAction(
                            doctorId: int.parse(widget.doctor.id.toString()),
                          ),
                        );
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
      body: BlocListener<GetChatDoctorBloc, GetChatDoctorState>(
        listener: (context, stateChat) {
          if (stateChat is GetChatDoctorLoaded) {
            context.goNamed(
              'chat_dokter',
              extra: {
                'doctor': widget.doctor,
                'idChat': stateChat.chats.id,
              },
              pathParameters: {
                'name': widget.doctor.kategori,
                'id': widget.doctor.id.toString(),
                'name_dokter': widget.doctor.name,
              },
            );
          } else if (stateChat is GetChatDoctorNotFound) {
            context.read<OpenChatBloc>().add(
                  OnOpenChat(
                    receiverId: int.parse(widget.doctor.id.toString()),
                  ),
                );
          } else if (stateChat is GetChatDoctorError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(stateChat.message)),
            );
          }
        },
        child: BlocListener<OpenChatBloc, OpenChatState>(
          listener: (context, state) {
            if (state is OpenChatSuccess) {
              context.goNamed(
                'chat_dokter',
                extra: {
                  'doctor': widget.doctor,
                  'idChat': state.idChat,
                },
                pathParameters: {
                  'name': widget.doctor.kategori,
                  'id': widget.doctor.id.toString(),
                  'name_dokter': widget.doctor.name,
                },
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
          BlocListener<DeleteFavoriteBloc, DeleteFavoriteState>(
            listener: (context, state) {
              if (state is DeleteFavoriteSuccess) {
                context
                    .read<CheckFavoriteBloc>()
                    .add(OnCheckFavorite(doctorId: widget.doctor.id));
              }
            },
            child: BlocListener<AddFavoriteBloc, AddFavoriteState>(
              listener: (context, state) {
                if (state is AddFavoriteSuccess) {
                  context
                      .read<CheckFavoriteBloc>()
                      .add(OnCheckFavorite(doctorId: widget.doctor.id));
                }
              },
              child: BlocBuilder<CheckFavoriteBloc, CheckFavoriteState>(
                builder: (context, state) {
                  if (state is CheckFavoriteSuccess) {
                    return InkWell(
                      onTap: () {
                        state.isFavorite
                            ? {
                                context
                                    .read<DeleteFavoriteBloc>()
                                    .add(OnDeleteFavorite(widget.doctor.id))
                              }
                            : context
                                .read<AddFavoriteBloc>()
                                .add(OnAddFavorite(widget.doctor.id));
                      },
                      borderRadius: BorderRadius.circular(50),
                      splashColor: Colors.grey.withOpacity(0.2),
                      highlightColor: Colors.grey.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.favorite,
                          size: 20,
                          color: state.isFavorite
                              ? MyColor.biruIndicator
                              : MyColor.abuForm,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
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
