import 'package:konsul_dok/features/appointment/domain/entities/appointment.dart';
import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';

class SuccessOrderArgs {
  final Doctor doctor;
  final Appointment appointment;
  final User user;

  SuccessOrderArgs(
      {required this.doctor, required this.appointment, required this.user});
}
