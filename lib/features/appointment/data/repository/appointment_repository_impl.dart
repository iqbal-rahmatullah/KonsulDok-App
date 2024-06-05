import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/appointment/data/datasource/appointment_remote_datasource.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment.dart';
import 'package:konsul_dok/features/appointment/domain/entities/appointment_patient.dart';
import 'package:konsul_dok/features/appointment/domain/entities/clock_appointment.dart';
import 'package:konsul_dok/features/appointment/domain/repository/appointment_repository.dart';
import 'package:konsul_dok/utils/error/exception.dart';
import 'package:konsul_dok/utils/error/failure.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource appointmentRemoteDataSource;

  AppointmentRepositoryImpl({required this.appointmentRemoteDataSource});

  @override
  Future<Either<Failure, Appointment>> createAppointment(
      {required int patientId,
      required int doctorId,
      required String date,
      required String time}) async {
    try {
      final result = await appointmentRemoteDataSource.createAppointment(
          patientId: patientId, doctorId: doctorId, date: date, time: time);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentPatient>>>
      getAppointmentPatient() async {
    try {
      final result = await appointmentRemoteDataSource.getDetailAppointment();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentPatient>>>
      getAppointmentDoctor() async {
    try {
      final result =
          await appointmentRemoteDataSource.getDetailAppointmentDoctor();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ClockAppointment>>> getClockAppointment(
      {required int doctorId, required String date}) async {
    try {
      final result = await appointmentRemoteDataSource.getClockAppointment(
          doctorId: doctorId, date: date);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateStatusAppointment(
      {required int appointmentId, required String status}) async {
    try {
      final response =
          await appointmentRemoteDataSource.updateStatusAppointment(
              appointmentId: appointmentId, status: status);
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
