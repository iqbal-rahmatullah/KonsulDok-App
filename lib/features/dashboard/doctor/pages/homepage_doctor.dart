import 'package:flutter/material.dart';
import 'package:konsul_dok/pages/card_transaction.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class HomepageDoctor extends StatefulWidget {
  const HomepageDoctor({super.key});

  @override
  State<HomepageDoctor> createState() => _HomepageDoctorState();
}

class _HomepageDoctorState extends State<HomepageDoctor> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: topBar(),
          centerTitle: false,
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
              Text("cek"),
              Text("cek2"),

              // cardTransaction(context: context),
              // cardTransaction(isOrdered: true, context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        margin: MySpacing.defaultMarginItem,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset('assets/images/small_icon.png'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Halo, ",
                  style: MyTextStyle.subheder
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Dr. Anas",
                  style: MyTextStyle.subheder.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_active,
                color: MyColor.biru,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
