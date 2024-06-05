import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/appointment/domain/repository/appointment_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class UpdateStatusAppointmentCase
    extends UseCase<void, UpdateStatusAppointmentParams> {
  final AppointmentRepository repository;

  UpdateStatusAppointmentCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(
      UpdateStatusAppointmentParams params) async {
    return await repository.updateStatusAppointment(
        appointmentId: params.appointmentId, status: params.status);
  }
}

class UpdateStatusAppointmentParams {
  final int appointmentId;
  final String status;

  UpdateStatusAppointmentParams(
      {required this.appointmentId, required this.status});
}
