import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:konsul_dok/features/appointment/presentation/bloc/appointment_bloc.dart';
import 'package:konsul_dok/features/appointment/presentation/bloc/clock_appointment/bloc/clock_appointment_bloc.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/utils/clock.dart';
import 'package:konsul_dok/utils/color.dart';
import 'package:konsul_dok/utils/spacing.dart';
import 'package:konsul_dok/utils/success_order/success_order_args.dart';
import 'package:konsul_dok/utils/textstyle.dart';
import 'package:konsul_dok/widgets/button_widget.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:konsul_dok/widgets/card_detail_dokter.dart';
import 'package:konsul_dok/widgets/custom_snackbar.dart';
import 'package:konsul_dok/widgets/radio_button_jam.dart';

class OrderPage extends StatefulWidget {
  final Doctor doctor;
  const OrderPage({super.key, required this.doctor});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Map formData = {
    "date": DateTime.now(),
    "time": null,
  };

  @override
  void initState() {
    context.read<ClockAppointmentBloc>().add(
          GetClockAppointmentEvent(
            doctorId: widget.doctor.id,
            date:
                "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patient = context.read<AuthBloc>().state as AuthGetUserSuccess;

    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentError) {
          CustomSnackbar.showErrorSnackbar(context, state.message);
        } else if (state is AppointmentSuccess) {
          context.goNamed(
            'success_order',
            extra: SuccessOrderArgs(
              doctor: widget.doctor,
              appointment: state.appointment,
              user: patient.user,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Buat Janji",
              style: MyTextStyle.subheder.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Container(
            padding: MySpacing.paddingInsetPage,
            child: Column(
              children: [
                headerProfileDokter(),
                Container(
                  margin: MySpacing.defaultMarginItem,
                  child: cardDetailDokter(
                    rating: widget.doctor.averageRating ?? 0,
                    experience: widget.doctor.experience,
                    price: widget.doctor.price.toString(),
                  ),
                ),
                inputTimeSection(),
                actionChatSection(),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: MySpacing.paddingPage.copyWith(bottom: 50),
            child: myButtonWidget(
              text: "Buat Janji",
              isLoading: state is AppointmentLoading,
              onTap: () {
                if (formData['time'] == null) {
                  CustomSnackbar.showErrorSnackbar(
                      context, "Anda belum memilih waktu");
                  return;
                }
                String dateSubmit =
                    "${formData['date'].day}-${formData['date'].month}-${formData['date'].year}";
                String timeSubmit = "${7 + formData['time']}:00";

                context.read<AppointmentBloc>().add(
                      CreateAppointmentEvent(
                        patientId: patient.user.id,
                        doctorId: widget.doctor.id,
                        date: dateSubmit,
                        time: timeSubmit,
                      ),
                    );
              },
            ),
          ),
        );
      },
    );
  }

  Widget headerProfileDokter() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        children: [
          Stack(children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                "${widget.doctor.photoProfile}&s=${widget.doctor.id}",
              ),
            ),
          ]),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.doctor.name,
                style: MyTextStyle.subheder.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Poli ${widget.doctor.kategori}",
                style: MyTextStyle.deskripsi.copyWith(
                  color: MyColor.abuTextDescription,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: MyColor.biruIndicator,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    widget.doctor.hospitalName,
                    style: MyTextStyle.deskripsi.copyWith(color: MyColor.abu),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget inputTimeSection() {
    DatePickerController _dateController = DatePickerController();

    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Atur Jadwal",
            style: MyTextStyle.subheder.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Hari",
            style: MyTextStyle.deskripsi.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DatePicker(
            DateTime.now(),
            controller: _dateController,
            initialSelectedDate: DateTime.now(),
            selectionColor: MyColor.biru,
            selectedTextColor: Colors.white,
            monthTextStyle: MyTextStyle.deskripsi.copyWith(
              fontSize: 8,
            ),
            dateTextStyle: MyTextStyle.subheder.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            dayTextStyle: MyTextStyle.deskripsi.copyWith(
              fontSize: 8,
              color: const Color(0xff4C4242),
            ),
            locale: 'id',
            daysCount: 7,
            height: 90,
            onDateChange: (date) {
              formData['time'] = null;
              formData['date'] = date;
              context.read<ClockAppointmentBloc>().add(
                    GetClockAppointmentEvent(
                      doctorId: widget.doctor.id,
                      date: "${date.year}-${date.month}-${date.day}",
                    ),
                  );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Jam",
            style: MyTextStyle.deskripsi.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 50),
            child: BlocBuilder<ClockAppointmentBloc, ClockAppointmentState>(
                builder: (context, state) {
              if (state is ClockAppointmentLoaded) {
                DateTime now = DateTime.now();
                DateTime limitTime = now.add(const Duration(hours: 1));

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Clock.date.length,
                    itemBuilder: (context, index) {
                      DateTime clockTime = DateTime(
                        formData['date'].year,
                        formData['date'].month,
                        formData['date'].day,
                        int.parse(Clock.date[index].split(':')[0]),
                        int.parse(Clock.date[index].split(':')[1]),
                      );

                      bool isDisabled = state.clockAppointments
                              .any((e) => e.time == Clock.date[index]) ||
                          clockTime.isBefore(limitTime);

                      return Row(
                        children: [
                          customRadioButton(
                            label: Clock.date[index],
                            isSelected: formData['time'] == index,
                            isDisabled: isDisabled,
                            onTap: () {
                              setState(() {
                                formData['time'] = index;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      );
                    });
              } else if (state is ClockAppointmentError) {
                return Text(state.message);
              }
              return const CircularProgressIndicator();
            }),
          )
        ],
      ),
    );
  }

  Widget actionChatSection() {
    return Container(
      margin: MySpacing.defaultMarginItem,
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: MyColor.putihForm,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ingin membuat janji di luar jadwal?",
                  style: MyTextStyle.deskripsi,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Chat dokter",
                    style: MyTextStyle.deskripsi.copyWith(
                      color: MyColor.biru,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
