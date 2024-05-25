import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class GetDoctorById implements UseCase<Doctor, GetDoctorByIdParams> {
  final DoctorRepository repository;

  GetDoctorById({required this.repository});

  @override
  Future<Either<Failure, Doctor>> call(GetDoctorByIdParams params) async {
    return await repository.getDoctorById(id: params.id);
  }
}

class GetDoctorByIdParams {
  final String id;

  GetDoctorByIdParams({required this.id});
}
