import 'package:dio/dio.dart';
import 'package:konsul_dok/features/appointment/data/model/appointment_model.dart';
import 'package:konsul_dok/utils/api.dart';
import 'package:konsul_dok/utils/error/exception.dart';

abstract class AppointmentRemoteDataSource {
  Future<AppointmentModel> createAppointment({
    required int patientId,
    required int doctorId,
    required String date,
    required String time,
  });
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
}
