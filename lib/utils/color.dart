import "package:flutter/material.dart";

class MyColor {
  static const Color hitam = Color(0xff000000);
  static const LinearGradient gradientBiru = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.1, 1],
    colors: [Color(0xff67C6E3), Color(0xff378CE7)],
  );

  static LinearGradient gradientLoading = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: const [0.1, 1],
    colors: [
      const Color(0xff67C6E3).withOpacity(0.5),
      const Color(0xff378CE7).withOpacity(0.5)
    ],
  );

  static const List<Color> gradientText = [
    Color(0xff67C6E3),
    Color(0xff378CE7)
  ];
  static const Color abu = Color(0xff373737);
  static const Color biru = Color(0xff5FA1FF);
  static const Color biruIndicator = Color(0xff378CE7);
  static const Color putih = Color(0xffFFFFFF);
  static const Color putihForm = Color(0xffEFEFEF);
  static const Color abuForm = Color(0xffB7B7B7);
  static const Color abuText = Color(0xff909090);
  static const Color yellowStar = Color(0xffFFD748);
  static const Color blackAppbar = Color(0xff0A0A0A);
  static const Color abuDivider = Color(0xffB5B5B5);
  static const Color abuTextDescription = Color(0xff343232);
  static const Color buttonDisabled = Color(0xff6B779A);
  static const Map<String, Color> colorSnackbar = {
    "success_bg": Color(0xffF1F6F3),
    "success_icon": Color(0xff49D95D),
    "error_bg": Color(0xffFAF0ED),
    "error_icon": Color(0xffF95B51),
  };
}
