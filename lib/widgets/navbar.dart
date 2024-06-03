// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function onItemTapped;
  final List<Map> itemNavbar;

  const MyBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.itemNavbar,
  }) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: BottomNavigationBar(
              backgroundColor: MyColor.putih,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle:
                  MyTextStyle.deskripsi.copyWith(color: MyColor.abuText),
              showUnselectedLabels: true,
              unselectedItemColor: MyColor.abuText,
              items: List.generate(widget.itemNavbar.length, (index) {
                return BottomNavigationBarItem(
                  icon: widget.itemNavbar[index]['icon'] as Widget,
                  label: widget.itemNavbar[index]['label'] as String,
                );
              }),
              selectedLabelStyle: MyTextStyle.deskripsi
                  .copyWith(color: MyColor.biru, fontWeight: FontWeight.w500),
              currentIndex: widget.selectedIndex,
              selectedItemColor: MyColor.biru,
              onTap: (index) {
                widget.onItemTapped(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
