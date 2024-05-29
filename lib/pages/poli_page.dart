// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.namaPoli,
          style: MyTextStyle.subheder.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
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

  Widget searchField() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      // child: textField(),
    );
  }

  Widget listDokter() {
    return Column(children: [
      cardDokter(context: context),
      cardDokter(context: context),
    ]);
  }
}
