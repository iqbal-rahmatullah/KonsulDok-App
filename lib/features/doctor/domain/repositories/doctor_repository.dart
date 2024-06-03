import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/doctor/domain/entities/doctor.dart';
import 'package:konsul_dok/utils/error/failure.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<Doctor>>> getAllDoctors({required String name});
  Future<Either<Failure, Doctor>> getDoctorById({required String id});
}
