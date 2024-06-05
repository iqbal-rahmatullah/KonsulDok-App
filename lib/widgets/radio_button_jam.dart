import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget customRadioButton({
  required String label,
  required bool isSelected,
  bool isDisabled = false,
  required Function() onTap,
}) {
  return InkWell(
    onTap: isDisabled ? null : onTap,
    borderRadius: BorderRadius.circular(10),
    child: Ink(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: (isSelected) ? MyColor.gradientBiru : null,
        color: isDisabled ? MyColor.buttonDisabled.withOpacity(0.3) : null,
        border: (!isSelected || isDisabled)
            ? Border.all(
                color: const Color(0xff6B779A).withOpacity(0.1),
              )
            : null,
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: MyTextStyle.deskripsi.copyWith(
            fontWeight: FontWeight.w500,
            color: (isSelected) ? MyColor.putih : MyColor.hitam,
          ),
        ),
      ),
    ),
  );
}
