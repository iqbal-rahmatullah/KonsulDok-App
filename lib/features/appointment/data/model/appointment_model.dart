import 'package:konsul_dok/features/appointment/domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  AppointmentModel({
    required super.patientId,
    required super.doctorId,
    required super.date,
    required super.time,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      date: json['date'],
      time: json['time'],
    );
  }
}
