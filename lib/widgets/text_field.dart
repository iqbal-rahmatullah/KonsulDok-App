import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget textField(
    {Icon? prefixIcon,
    required String hintText,
    required TextEditingController controller}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: MyTextStyle.deskripsi.copyWith(color: MyColor.abuForm),
      prefixIcon: prefixIcon,
      prefixIconColor: MyColor.abuForm,
      fillColor: MyColor.putihForm,
      contentPadding: prefixIcon == null
          ? const EdgeInsets.symmetric(horizontal: 10)
          : const EdgeInsets.all(0),
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
