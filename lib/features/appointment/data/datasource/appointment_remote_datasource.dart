import 'package:dio/dio.dart';
import 'package:konsul_dok/features/appointment/data/model/appointment_model.dart';
import 'package:konsul_dok/features/appointment/data/model/appointment_patient_model.dart';
import 'package:konsul_dok/utils/api.dart';
import 'package:konsul_dok/utils/error/exception.dart';

abstract class AppointmentRemoteDataSource {
  Future<AppointmentModel> createAppointment({
    required int patientId,
    required int doctorId,
    required String date,
    required String time,
  });

  Future<List<AppointmentPatientModel>> getDetailAppointment({required int id});
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final Dio dio;

  AppointmentRemoteDataSourceImpl({required this.dio});

  @override
  Future<AppointmentModel> createAppointment(
      {required int patientId,
      required int doctorId,
      required String date,
      required String time}) async {
    try {
      final result = await dio.post('${ApiEnv.apiUrl}/appointment/', data: {
        'patient_id': patientId,
        'doctor_id': doctorId,
        'date': date,
        'time': time,
      }).timeout(const Duration(seconds: 10));

      return AppointmentModel.fromJson(result.data['data']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<AppointmentPatientModel>> getDetailAppointment(
      {required int id}) async {
    try {
      final result = await dio
          .get('${ApiEnv.apiUrl}/appointment/patient/$id')
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
}
