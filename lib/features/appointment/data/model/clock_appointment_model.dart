import 'package:konsul_dok/features/appointment/domain/entities/clock_appointment.dart';

class ClockAppointmentModel extends ClockAppointment {
  ClockAppointmentModel({required super.time});

  factory ClockAppointmentModel.fromJson(Map<String, dynamic> json) {
    return ClockAppointmentModel(time: json['time']);
  }
}
