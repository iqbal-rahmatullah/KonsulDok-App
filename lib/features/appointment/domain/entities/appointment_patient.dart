import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';

abstract class AppointmentPatient {
  final int id;
  final String date;
  final String time;
  final int patientId;
  final int doctorId;
  final String status;
  final Doctor doctor;
  final User patient;

  AppointmentPatient(
      {required this.id,
      required this.date,
      required this.time,
      required this.patientId,
      required this.doctorId,
      required this.status,
      required this.doctor,
      required this.patient});
}
