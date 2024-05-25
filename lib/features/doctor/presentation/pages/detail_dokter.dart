import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:konsul_dok/features/doctor/presentation/pages/loading/loading_detail_dokter_page.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/card_detail_dokter.dart';
import 'package:konsul_dok/widgets/card_rating.dart';

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
                  onTap: () {},
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
      body: Container(
        padding: MySpacing.paddingInsetPage,
        child: SingleChildScrollView(
          child: BlocConsumer<DoctorBloc, DoctorState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is DoctorLoading) {
                  return const Center(
                    child: LoadingDetailDokterPage(),
                  );
                } else if (state is DoctorError) {
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
                return const SizedBox();
              }),
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
            state.doctor.photoProfile,
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
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ulasan",
                style:
                    MyTextStyle.subheder.copyWith(fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Lihat Semua (10)",
                  style: MyTextStyle.deskripsi.copyWith(
                    color: MyColor.biru,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          cardRating(),
          cardRating(),
          cardRating(),
        ],
      ),
    );
  }
}
