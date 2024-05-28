import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/utils/error/failure.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, Appointment>> createAppointment({
    required int patientId,
    required int doctorId,
    required String date,
    required String time,
  });

  Future<Either<Failure, List<AppointmentPatient>>> getAppointmentPatient(
      {required int id});

  Future<Either<Failure, List<AppointmentPatient>>> getAppointmentDoctor(
      {required int id});
}
