import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget otherChat(
    {required BuildContext context,
    required String message,
    required ImageProvider image}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          backgroundImage: image,
        ),
        const SizedBox(
          width: 7,
        ),
        Container(
          decoration: BoxDecoration(
            color: MyColor.putih,
            border: Border.all(
              color: MyColor.abuForm,
              width: 0.5,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          child: Text(
            message,
            style: MyTextStyle.deskripsi.copyWith(
              color: MyColor.hitam,
            ),
          ),
        ),
      ],
    ),
  );
}
