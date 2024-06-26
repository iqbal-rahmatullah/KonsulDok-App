import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/features/appointment/domain/usecase/get_appointment_patient.dart';
import 'package:konsul_dok/features/appointment/presentation/bloc/appointment_patient/bloc/appointment_patient_bloc.dart';
import 'package:konsul_dok/features/appointment/presentation/bloc/update_status_appointment/update_status_appointment_bloc.dart';
import 'package:konsul_dok/features/rating/presentation/bloc/add_rating/add_rating_bloc.dart';
import 'package:konsul_dok/features/rating/presentation/bloc/check_rating_appointment/check_rating_appointment_bloc.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:konsul_dok/widgets/custom_snackbar.dart';

class DetailJanjiPasien extends StatefulWidget {
  final AppointmentPatient appointmentPatient;
  final bool pageDoctor;

  const DetailJanjiPasien({
    super.key,
    required this.appointmentPatient,
    this.pageDoctor = false,
  });

  @override
  State<DetailJanjiPasien> createState() => _DetailJanjiPasienState();
}

class _DetailJanjiPasienState extends State<DetailJanjiPasien> {
  @override
  void initState() {
    context
        .read<CheckRatingAppointmentBloc>()
        .add(OnCheckRatingAppointment(widget.appointmentPatient.id));
    super.initState();
  }

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
        child: widget.pageDoctor
            ? widget.appointmentPatient.status == "ongoing"
                ? myButtonWidget(
                    text: "Tandai telah selesai",
                    onTap: () {
                      showModalSuccess();
                    },
                    color: const Color(0xff49D95D),
                  )
                : null
            : widget.appointmentPatient.status == "ongoing"
                ? myButtonWidget(
                    text: "Batalkan",
                    onTap: () {
                      showModalCancel();
                    },
                    color: const Color(0xffFF6161),
                  )
                : (widget.appointmentPatient.status == "done")
                    ? BlocBuilder<CheckRatingAppointmentBloc,
                        CheckRatingAppointmentState>(
                        builder: (context, state) {
                          if (state is CheckRatingAppointmentSuccess) {
                            return state.isRated
                                ? const SizedBox()
                                : myButtonWidget(
                                    text: "Beri ulasan",
                                    onTap: () {
                                      showModalRating();
                                    },
                                    color: MyColor.biru,
                                  );
                          } else if (state is CheckRatingAppointmentError) {
                            return Text(state.message);
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                    : null,
      ),
      body: BlocListener<AddRatingBloc, AddRatingState>(
        listener: (context, state) {
          if (state is AddRatingSuccess) {
            Navigator.pop(context);
            CustomSnackbar.showSuccessSnackbar(
                context, "Ulasan berhasil dikirim");
            context
                .read<CheckRatingAppointmentBloc>()
                .add(OnCheckRatingAppointment(widget.appointmentPatient.id));
          } else if (state is AddRatingError) {
            CustomSnackbar.showErrorSnackbar(context, state.message);
          }
        },
        child: BlocListener<UpdateStatusAppointmentBloc,
            UpdateStatusAppointmentState>(
          listener: (context, state) {
            if (state is UpdateStatusAppointmentSuccess) {
              Navigator.of(context).pop();
              CustomSnackbar.showSuccessSnackbar(
                  context, "Berhasil memperbarui appointment");

              Future.delayed(const Duration(milliseconds: 500), () {
                if (widget.pageDoctor) {
                  context
                      .read<AppointmentPatientBloc>()
                      .add(GetAppointmentDoctorEvent());
                  context.goNamed('home_doctor');
                } else {
                  context
                      .read<AppointmentPatientBloc>()
                      .add(GetAppointmentPatientEvent());
                  context.goNamed('home');
                }
              });
            } else if (state is UpdateStatusAppointmentError) {
              CustomSnackbar.showErrorSnackbar(context, state.message);
            }
          },
          child: Container(
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
        ),
      ),
    );
  }

  Future<void> showModalSuccess() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Apakah Anda yakin ingin menyelesaikan janji ini?',
                  style: MyTextStyle.subheder),
              const SizedBox(height: 20),
              BlocBuilder<UpdateStatusAppointmentBloc,
                  UpdateStatusAppointmentState>(
                builder: (context, state) {
                  return myButtonWidget(
                    text: "Konfirmasi Selesai",
                    color: MyColor.colorSnackbar['success_icon'],
                    onTap: () {
                      context.read<UpdateStatusAppointmentBloc>().add(
                          OnUpdateStatusAppointment(
                              widget.appointmentPatient.id, "done"));
                    },
                    isLoading: state is UpdateStatusAppointmentLoading,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showModalCancel() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Apakah Anda yakin ingin membatalkan janji ini?',
                  style: MyTextStyle.subheder),
              const SizedBox(height: 20),
              BlocBuilder<UpdateStatusAppointmentBloc,
                  UpdateStatusAppointmentState>(
                builder: (context, state) {
                  return myButtonWidget(
                    text: "Konfirmasi Pembatalan",
                    color: MyColor.colorSnackbar['error_icon'],
                    onTap: () {
                      context.read<UpdateStatusAppointmentBloc>().add(
                          OnUpdateStatusAppointment(
                              widget.appointmentPatient.id, "cancel"));
                    },
                    isLoading: state is UpdateStatusAppointmentLoading,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showModalRating() {
    double handleRating = 0;

    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Berikan ulasan Anda untuk dokter ini',
                  style: MyTextStyle.subheder),
              const SizedBox(
                height: 10,
              ),
              RatingBar.builder(
                itemSize: 40,
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: MyColor.yellowStar,
                ),
                onRatingUpdate: (rating) {
                  handleRating = rating;
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<AddRatingBloc, AddRatingState>(
                builder: (context, state) {
                  return myButtonWidget(
                    text: "Kirim Ulasan",
                    onTap: () {
                      context.read<AddRatingBloc>().add(
                            OnAddRating(
                              widget.appointmentPatient.id,
                              handleRating.toInt(),
                            ),
                          );
                    },
                    isLoading: state is AddRatingLoading,
                  );
                },
              )
            ],
          ),
        );
      },
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
                          widget.pageDoctor
                              ? widget.appointmentPatient.patient.name
                              : widget.appointmentPatient.doctor.name,
                          overflow: TextOverflow.ellipsis,
                          style: MyTextStyle.name.copyWith(
                            color: MyColor.putih,
                          ),
                        ),
                        Text(
                          widget.pageDoctor
                              ? widget.appointmentPatient.patient.gender
                              : "Dokter ${widget.appointmentPatient.doctor.kategori}",
                          style: MyTextStyle.deskripsi.copyWith(
                              color: MyColor.putih,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.pageDoctor
                              ? "${widget.appointmentPatient.patient.age} Tahun"
                              : widget.appointmentPatient.doctor.hospitalName,
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

  Widget statusBar(String label, String isi) {
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
              decoration: BoxDecoration(
                color: (isi == "ongoing")
                    ? MyColor.biru
                    : (isi == "done")
                        ? MyColor.colorSnackbar['success_icon']
                        : MyColor.colorSnackbar['error_icon'],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                isi,
                textAlign: TextAlign.left,
                style: MyTextStyle.deskripsi.copyWith(color: MyColor.putih),
              ),
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
          statusBar("Status", widget.appointmentPatient.status),
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
