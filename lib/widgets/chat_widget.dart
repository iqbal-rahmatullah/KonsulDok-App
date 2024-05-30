import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:konsul_dok/features/chat/presentation/pages/chat_open.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget chatWidget({
  required BuildContext context,
  Doctor? doctor,
  User? patient,
  required List<ChatDetail> messages,
  required int idChat,
}) {
  final allChats =
      messages.where((element) => element.chatId == idChat).toList();

  return GestureDetector(
    onTap: () {
      context.goNamed('open_chat', extra: allChats, pathParameters: {
        'name': doctor != null ? doctor.name : patient!.name
      });
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
            const CircleAvatar(
              backgroundImage: AssetImage(
                "assets/images/doctor-example.jpg",
              ),
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
                            messages.last.message,
                            style: MyTextStyle.deskripsi
                                .copyWith(color: MyColor.hitam),
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    "07.56",
                    style:
                        MyTextStyle.deskripsi.copyWith(color: MyColor.abuText),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
