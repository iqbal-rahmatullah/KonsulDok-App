import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:konsul_dok/features/appointment/data/model/appointment_model.dart';
import 'package:konsul_dok/features/appointment/data/model/appointment_patient_model.dart';
import 'package:konsul_dok/features/appointment/data/model/clock_appointment_model.dart';
import 'package:konsul_dok/utils/api.dart';
import 'package:konsul_dok/utils/error/exception.dart';

abstract class AppointmentRemoteDataSource {
  Future<AppointmentModel> createAppointment({
    required int patientId,
    required int doctorId,
    required String date,
    required String time,
  });

  Future<List<AppointmentPatientModel>> getDetailAppointment();
  Future<List<AppointmentPatientModel>> getDetailAppointmentDoctor();
  Future<List<ClockAppointmentModel>> getClockAppointment(
      {required int doctorId, required String date});
  Future<void> updateStatusAppointment(
      {required int appointmentId, required String status});
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final Dio dio;
  final Box<String> box;

  AppointmentRemoteDataSourceImpl({required this.dio, required this.box});

  @override
  Future<AppointmentModel> createAppointment(
      {required int patientId,
      required int doctorId,
      required String date,
      required String time}) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final result = await dio
          .post(
            '${ApiEnv.apiUrl}/appointment/',
            data: {
              'patient_id': patientId,
              'doctor_id': doctorId,
              'date': date,
              'time': time,
            },
            options: Options(
              headers: {
                'Authorization': session,
              },
            ),
          )
          .timeout(const Duration(seconds: 10));

      return AppointmentModel.fromJson(result.data['data']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<AppointmentPatientModel>> getDetailAppointment() async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final result = await dio
          .get(
            '${ApiEnv.apiUrl}/appointment/patient/',
            options: Options(
              headers: {
                'Authorization': session,
              },
            ),
          )
          .timeout(const Duration(seconds: 10));
      List<AppointmentPatientModel> appointments = [];

      for (var item in result.data['data']) {
        appointments.add(AppointmentPatientModel.fromJson(item));
      }

      return appointments;
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 404) {
        return [];
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<AppointmentPatientModel>> getDetailAppointmentDoctor() async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final result = await dio
          .get(
            '${ApiEnv.apiUrl}/appointment/doctor/',
            options: Options(
              headers: {
                'Authorization': session,
              },
            ),
          )
          .timeout(const Duration(seconds: 10));
      List<AppointmentPatientModel> appointments = [];

      for (var item in result.data['data']) {
        appointments.add(AppointmentPatientModel.fromJson(item));
      }

      return appointments;
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 404) {
        throw ServerException(e.response!.data['message']);
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ClockAppointmentModel>> getClockAppointment(
      {required int doctorId, required String date}) async {
    try {
      final result = await dio
          .get(
            '${ApiEnv.apiUrl}/appointment/clock/$doctorId',
            data: {
              "date": date,
            },
            options: Options(
              headers: {
                'Authorization': box.get('token'),
              },
            ),
          )
          .timeout(const Duration(seconds: 10));

      List<ClockAppointmentModel> clockAppointmens = [];
      for (var item in result.data['data']) {
        clockAppointmens.add(ClockAppointmentModel.fromJson(item));
      }

      return clockAppointmens;
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 404) {
        return [];
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateStatusAppointment(
      {required int appointmentId, required String status}) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      await dio
          .put(
            '${ApiEnv.apiUrl}/appointment/$appointmentId',
            data: {
              'status': status,
            },
            options: Options(
              headers: {
                'Authorization': session,
              },
            ),
          )
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 404) {
        throw ServerException(e.response!.data['message']);
      }
      throw ServerException(e.toString());
    }
  }
}
