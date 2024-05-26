import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';

class DetailJanjiPasien extends StatefulWidget {
  final AppointmentPatient appointmentPatient;
  const DetailJanjiPasien({super.key, required this.appointmentPatient});

  @override
  State<DetailJanjiPasien> createState() => _DetailJanjiPasienState();
}

class _DetailJanjiPasienState extends State<DetailJanjiPasien> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Janji Saya',
          style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MySpacing.paddingInsetPage.copyWith(bottom: 20),
        child: myButtonWidget(
            text: "Batalkan", onTap: () {}, color: const Color(0xffFF6161)),
      ),
      body: Container(
        padding: MySpacing.paddingInsetPage,
        child: Column(
          children: [
            cardHome(),
            const SizedBox(
              height: 15,
            ),
            detailDokter(),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                color: MyColor.abuText,
                thickness: 1,
              ),
            ),
            detailJanji(),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                color: MyColor.abuText,
                thickness: 1,
              ),
            ),
            detailPasien(),
          ],
        ),
      ),
    );
  }

  Widget cardHome() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            decoration: BoxDecoration(
                gradient: MyColor.gradientBiru,
                borderRadius: BorderRadius.circular(20)),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.appointmentPatient.date,
                        textAlign: TextAlign.center,
                        style: MyTextStyle.subheder.copyWith(
                            color: MyColor.putih, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${widget.appointmentPatient.time} WIB",
                        textAlign: TextAlign.center,
                        style: MyTextStyle.subheder.copyWith(
                            color: MyColor.putih, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    color: MyColor.putih,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.appointmentPatient.doctor.name,
                          overflow: TextOverflow.ellipsis,
                          style: MyTextStyle.name.copyWith(
                            color: MyColor.putih,
                          ),
                        ),
                        Text(
                          "Poli ${widget.appointmentPatient.doctor.kategori}",
                          style: MyTextStyle.deskripsi.copyWith(
                              color: MyColor.putih,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.appointmentPatient.doctor.hospitalName,
                          style: MyTextStyle.deskripsi.copyWith(
                              color: MyColor.putih,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget rowDescript(String label, String isi) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              textAlign: TextAlign.left,
              style: MyTextStyle.deskripsi.copyWith(color: MyColor.blackAppbar),
            ),
            Text(
              isi,
              textAlign: TextAlign.left,
              style: MyTextStyle.deskripsi.copyWith(color: MyColor.blackAppbar),
            ),
          ],
        ),
      ],
    );
  }

  Widget detailDokter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: MediaQuery.sizeOf(context).width * 7 / 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Dokter',
            textAlign: TextAlign.left,
            style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
          ),
          rowDescript("Nama dokter", widget.appointmentPatient.doctor.name),
          rowDescript("Poliklinik",
              "Poli ${widget.appointmentPatient.doctor.kategori}"),
          rowDescript(
              "Rumah sakit", widget.appointmentPatient.doctor.hospitalName),
        ],
      ),
    );
  }

  Widget detailJanji() {
    return SizedBox(
      // padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: MediaQuery.sizeOf(context).width * 7 / 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Janji',
            textAlign: TextAlign.left,
            style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
          ),
          rowDescript("Tanggal", widget.appointmentPatient.date),
          rowDescript("Jam", "${widget.appointmentPatient.time} WIB"),
          rowDescript("Status", widget.appointmentPatient.status),
        ],
      ),
    );
  }

  Widget detailPasien() {
    return SizedBox(
      // padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: MediaQuery.sizeOf(context).width * 7 / 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Pasien',
            textAlign: TextAlign.left,
            style: MyTextStyle.subheder.copyWith(color: MyColor.blackAppbar),
          ),
          rowDescript("Nama pasien", widget.appointmentPatient.patient.name),
          rowDescript(
              "Jenis kelamin", widget.appointmentPatient.patient.gender),
          rowDescript("Usia", "${widget.appointmentPatient.patient.age} tahun"),
        ],
      ),
    );
  }
}
