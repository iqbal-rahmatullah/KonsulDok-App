import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget textField() {
  return TextField(
    decoration: InputDecoration(
      hintText: "Cari Dokter",
      hintStyle: MyTextStyle.deskripsi.copyWith(color: MyColor.abuForm),
      prefixIcon: const Icon(Icons.search),
      prefixIconColor: MyColor.abuForm,
      fillColor: MyColor.putihForm,
      contentPadding: const EdgeInsets.all(0),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
    ),
    cursorColor: MyColor.hitam,
    style: MyTextStyle.deskripsi,
  );
}
