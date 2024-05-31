import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

class CustomSnackbar {
  static void showSuccessSnackbar(BuildContext context, String message) {
    Flushbar(
      titleText: Text(
        "Berhasil!",
        style: MyTextStyle.header.copyWith(color: MyColor.hitam, fontSize: 14),
      ),
      messageText: Text(
        message,
        style: MyTextStyle.deskripsi.copyWith(color: MyColor.abuForm),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      positionOffset: 50,
      backgroundColor: MyColor.colorSnackbar["success_bg"] as Color,
      animationDuration: const Duration(seconds: 1),
      messageColor: Colors.black,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: MyColor.colorSnackbar["success_icon"] as Color,
      ),
      duration: const Duration(seconds: 1, milliseconds: 500),
      leftBarIndicatorColor: MyColor.colorSnackbar["success_icon"] as Color,
      borderRadius: BorderRadius.circular(10),
      margin: MySpacing.paddingInsetPage,
    ).show(context);
  }

  static void showErrorSnackbar(BuildContext context, String message) {
    Flushbar(
      titleText: Text(
        "Terjadi kesalahan!",
        style: MyTextStyle.header.copyWith(color: MyColor.hitam, fontSize: 14),
      ),
      messageText: Text(
        message,
        style: MyTextStyle.deskripsi.copyWith(color: MyColor.abuForm),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      positionOffset: 50,
      backgroundColor: MyColor.colorSnackbar["error_bg"] as Color,
      animationDuration: const Duration(seconds: 1),
      messageColor: Colors.black,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: MyColor.colorSnackbar["error_icon"] as Color,
      ),
      duration: const Duration(seconds: 1, milliseconds: 500),
      leftBarIndicatorColor: MyColor.colorSnackbar["error_icon"] as Color,
      borderRadius: BorderRadius.circular(10),
      margin: MySpacing.paddingInsetPage,
    ).show(context);
  }
}
