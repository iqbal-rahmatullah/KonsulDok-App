import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/doctor/data/datasource/doctor_remote_data_source.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:konsul_dok/utils/error/exception.dart';
import 'package:konsul_dok/utils/error/failure.dart';

class DoctorRepoSitoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource doctorRemoteDataSource;

  DoctorRepoSitoryImpl({required this.doctorRemoteDataSource});

  @override
  Future<Either<Failure, List<Doctor>>> getAllDoctors(
      {required String name}) async {
    try {
      final result = await doctorRemoteDataSource.getAllDoctors(name: name);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Doctor>> getDoctorById({required String id}) async {
    try {
      final result = await doctorRemoteDataSource.getDoctorById(id: id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
