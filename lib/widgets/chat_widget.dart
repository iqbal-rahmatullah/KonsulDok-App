import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget chatWidget({
  required BuildContext context,
  Doctor? doctor,
  User? patient,
  required Chat messages,
  required int idChat,
}) {
  return GestureDetector(
    onTap: () {
      if (doctor != null) {
        context.goNamed(
          'open_chat',
          extra: {
            "idChat": messages.id,
            "doctor": doctor,
          },
          pathParameters: {
            "name": doctor.name,
          },
        );
      } else {
        context.goNamed(
          'doctor_chat',
          extra: {
            "idChat": messages.id,
            "patient": patient,
          },
          pathParameters: {
            "name": patient!.name,
          },
        );
      }
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: MyColor.abuForm,
            width: 0.5,
          ),
        ),
      ),
      child: Padding(
        padding: MySpacing.padingCard,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: (doctor != null)
                  ? NetworkImage(
                      "${doctor.photoProfile}&s=${doctor.id}",
                    )
                  : const AssetImage("assets/images/patient_profile.png")
                      as ImageProvider,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor != null ? doctor.name : patient!.name,
                        style: MyTextStyle.subheder.copyWith(
                          color: MyColor.hitam,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check,
                            color: MyColor.biruIndicator,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            messages.chat.last.message,
                            style: MyTextStyle.deskripsi
                                .copyWith(color: MyColor.hitam),
                          )
                        ],
                      )
                    ],
                  ),
                  (messages.countChat != null && messages.countChat! > 0)
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: MyColor.biruIndicator,
                              shape: BoxShape.circle),
                          child: Text(
                            messages.countChat.toString(),
                            style: MyTextStyle.deskripsi
                                .copyWith(color: MyColor.putih),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
