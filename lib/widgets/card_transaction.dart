import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';

Widget cardTransaction({
  bool isOrdered = false,
  required BuildContext context,
  required AppointmentPatient appointment,
  bool pageDoctor = false,
}) {
  return GestureDetector(
    onTap: () {
      context.goNamed(
        pageDoctor ? 'detail_appointment_doctor' : 'detail_appointment',
        extra: appointment,
      );
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: MyColor.putih,
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: MySpacing.padingCard,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appointment.date,
                      style: MyTextStyle.deskripsi.copyWith(color: MyColor.abu),
                    ),
                    Text(
                      "${appointment.time} WIB",
                      style: MyTextStyle.deskripsi.copyWith(color: MyColor.abu),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CircleAvatar(
                        backgroundImage: pageDoctor
                            ? const Image(
                                    image: AssetImage(
                                        "assets/images/patient_profile.png"))
                                .image
                            : NetworkImage(
                                "${appointment.doctor.photoProfile}&s=${appointment.doctor.id}"),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pageDoctor
                              ? appointment.patient.name
                              : appointment.doctor.name,
                          style: MyTextStyle.subheder.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Poli ${appointment.doctor.kategori}",
                          style: MyTextStyle.deskripsi
                              .copyWith(color: MyColor.abu),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: MyColor.biruIndicator,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              appointment.doctor.hospitalName,
                              style: MyTextStyle.deskripsi
                                  .copyWith(color: MyColor.abu),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
