import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget textFormField({
  required String hintText,
  required String label,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: MyTextStyle.deskripsi.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 6,
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: MyTextStyle.deskripsi.copyWith(color: MyColor.abuForm),
          fillColor: MyColor.putihForm,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
        cursorColor: MyColor.hitam,
        style: MyTextStyle.deskripsi,
      ),
    ],
  );
}
