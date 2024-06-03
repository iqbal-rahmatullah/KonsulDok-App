import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget ownChat(
    {required BuildContext context,
    required String message,
    required ImageProvider image}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: MyColor.biruIndicator,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          child: Text(
            message,
            style: MyTextStyle.deskripsi.copyWith(
              color: MyColor.putih,
            ),
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        CircleAvatar(
          backgroundImage: image,
        )
      ],
    ),
  );
}
