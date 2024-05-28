import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/features/appointment/domain/repository/appointment_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class GetAppointmentDoctor implements UseCase<List<AppointmentPatient>, int> {
  final AppointmentRepository _repository;

  GetAppointmentDoctor({required AppointmentRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<AppointmentPatient>>> call(int id) async {
    return await _repository.getAppointmentDoctor(id: id);
  }
}
