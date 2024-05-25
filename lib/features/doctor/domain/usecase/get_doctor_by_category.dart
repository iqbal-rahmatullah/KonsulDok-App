import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class GetDoctorByCategory
    implements UseCase<List<Doctor>, GetDoctorByCategoryParams> {
  final DoctorRepository repository;

  GetDoctorByCategory({required this.repository});

  @override
  Future<Either<Failure, List<Doctor>>> call(
      GetDoctorByCategoryParams params) async {
    return await repository.getAllDoctors(name: params.name);
  }
}

class GetDoctorByCategoryParams {
  final String name;

  GetDoctorByCategoryParams({
    required this.name,
  });
}
