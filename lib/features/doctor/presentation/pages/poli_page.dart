// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:konsul_dok/features/doctor/presentation/pages/loading/loading_poli_page.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/card_dokter.dart';
import 'package:konsul_dok/widgets/text_field.dart';

class PoliPage extends StatefulWidget {
  final String namaPoli;
  const PoliPage({
    Key? key,
    required this.namaPoli,
  }) : super(key: key);

  @override
  State<PoliPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DoctorBloc>(context)
        .add(DoctorGetCategory(name: widget.namaPoli));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Poli ${widget.namaPoli}",
          style: MyTextStyle.subheder.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<DoctorBloc, DoctorState>(
        builder: (context, state) {
          if (state is DoctorError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return SingleChildScrollView(
              child: Container(
                padding: MySpacing.paddingInsetPage,
                child: Column(
                  children: [
                    searchField(),
                    listDokter(),
                  ],
                ),
              ),
            );
          }
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget searchField() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: textField(),
    );
  }

  Widget listDokter() {
    final state = BlocProvider.of<DoctorBloc>(context).state;

    if (state is DoctorLoading || state is DoctorGetByIdLoaded) {
      return const LoadingPoliPage();
    } else if (state is DoctorGetCategoryLoaded) {
      if (state.doctors.isEmpty) {
        return const Center(
          child: Text("Data tidak ditemukan"),
        );
      } else {
        return Column(
            children: List.generate(state.doctors.length, (index) {
          return cardDokter(
            hospitalName: state.doctors[index].hospitalName,
            name: state.doctors[index].name,
            context: context,
            photoProfile: state.doctors[index].photoProfile,
            id: state.doctors[index].id.toString(),
            kategori: state.doctors[index].kategori,
          );
        }));
      }
    }
    return const SizedBox();
  }
}
