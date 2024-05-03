import "package:flutter/material.dart";

class MyColor {
  static const Color hitam = Color(0xff000000);
  static const LinearGradient gradientBiru = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.1, 1],
    colors: [Color(0xff67C6E3), Color(0xff378CE7)],
  );
  static const Color abu = Color(0xff373737);
  static const Color biru = Color(0xff5FA1FF);
  static const Color putih = Color(0xffFFFFFF);
  static const Color putihForm = Color(0xffEFEFEF);
  static const Color abuForm = Color(0xffB7B7B7);
  static const Color abuText = Color(0xff909090);
  static const Color yellowStar = Color(0xffFFD748);
}
