import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment.dart';
import 'package:konsul_dok/features/appointment/domain/repository/appointment_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class CreateAppointment extends UseCase<Appointment, CreateAppointmentParams> {
  final AppointmentRepository repository;

  CreateAppointment(this.repository);

  @override
  Future<Either<Failure, Appointment>> call(
      CreateAppointmentParams params) async {
    return await repository.createAppointment(
      patientId: params.patientId,
      doctorId: params.doctorId,
      date: params.date,
      time: params.time,
    );
  }
}

class CreateAppointmentParams {
  final int patientId;
  final int doctorId;
  final String date;
  final String time;

  CreateAppointmentParams(
      {required this.patientId,
      required this.doctorId,
      required this.date,
      required this.time});
}
