// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  void didChangeDependencies() {
    BlocProvider.of<DoctorBloc>(context)
        .add(DoctorGetCategory(name: widget.namaPoli));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DoctorBloc>(context)
        .add(DoctorGetCategory(name: widget.namaPoli));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            return Container(
              padding: MySpacing.paddingInsetPage,
              child: Column(
                children: [
                  searchField(),
                  Expanded(child: SingleChildScrollView(child: listDokter())),
                ],
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
      child: textField(
          hintText: "Cari dokter",
          controller: TextEditingController(),
          prefixIcon: const Icon(Icons.search)),
    );
  }

  Widget listDokter() {
    final state = BlocProvider.of<DoctorBloc>(context).state;

    if (state is DoctorLoading) {
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
            context: context,
            doctor: state.doctors[index],
          );
        }));
      }
    }
    return const SizedBox();
  }
}
