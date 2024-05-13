import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/pages/card_transaction.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Jadwal',
            style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: MyColor.putihForm),
                onPressed: () {},
                child: const Icon(
                  Icons.search,
                  color: MyColor.abuForm,
                ))
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Belum Selesai",
              ),
              Tab(
                text: "Selesai",
              ),
            ],
            indicatorColor: MyColor.biruIndicator,
            labelColor: MyColor.biruIndicator,
            dividerColor: MyColor.abuForm,
          ),
        ),
        body: Padding(
            padding: MySpacing.paddingInsetPage.copyWith(top: 20),
            child: TabBarView(
              children: [
                cardTransaction(context: context),
                cardTransaction(isOrdered: true, context: context),
              ],
            )),
      ),
    );
  }
}
