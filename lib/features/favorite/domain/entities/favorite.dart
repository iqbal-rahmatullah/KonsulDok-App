import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';

class Favorite {
  final int id;
  final int patientId;
  final int doctorId;
  final Doctor doctor;

  Favorite(
      {required this.id,
      required this.patientId,
      required this.doctorId,
      required this.doctor});
}
