import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/appointment/domain/entities/clock_appointment.dart';
import 'package:konsul_dok/features/appointment/domain/repository/appointment_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class GetClockAppointmentCase
    extends UseCase<List<ClockAppointment>, GetClockAppointmentParams> {
  final AppointmentRepository repository;

  GetClockAppointmentCase({required this.repository});

  @override
  Future<Either<Failure, List<ClockAppointment>>> call(
      GetClockAppointmentParams params) {
    return repository.getClockAppointment(
        date: params.date, doctorId: params.doctorId);
  }
}

class GetClockAppointmentParams {
  final int doctorId;
  final String date;

  GetClockAppointmentParams({required this.doctorId, required this.date});
}
