import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget myButtonWidget(
    {required String text,
    bool isLarge = true,
    double? ukuran,
    required Function onTap,
    Color? color,
    bool isLoading = false}) {
  return Container(
    width: (isLarge) ? double.infinity : ukuran,
    height: 45,
    decoration: BoxDecoration(
      gradient: color == null
          ? (isLoading)
              ? MyColor.gradientLoading
              : MyColor.gradientBiru
          : null,
      borderRadius: BorderRadius.circular(50),
      color: color,
    ),
    child: ElevatedButton(
        onPressed: isLoading ? null : () => onTap(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: MyTextStyle.subheder.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: isLarge ? 14 : 13,
                color: MyColor.putih,
              ),
            ),
            if (isLoading)
              Container(
                margin: const EdgeInsets.only(left: 10),
                height: 20,
                width: 20,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(MyColor.putih),
                ),
              ),
          ],
        )),
  );
}
