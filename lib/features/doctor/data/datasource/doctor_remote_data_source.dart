import 'package:dio/dio.dart';
import 'package:konsul_dok/features/doctor/data/model/doctor_model.dart';
import 'package:konsul_dok/utils/api.dart';
import 'package:konsul_dok/utils/error/exception.dart';

abstract class DoctorRemoteDataSource {
  Future<List<DoctorModel>> getAllDoctors({required String name});
  Future<DoctorModel> getDoctorById({required String id});
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final Dio dio;

  DoctorRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<DoctorModel>> getAllDoctors({required String name}) async {
    try {
      final result = await dio.get('${ApiEnv.apiUrl}/doctors/category/$name');
      final List<DoctorModel> doctors = [];
      for (var item in result.data['data']) {
        doctors.add(DoctorModel.fromJson(item));
      }

      return doctors;
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 404) {
        throw ServerException(e.response!.data['message']);
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<DoctorModel> getDoctorById({required String id}) async {
    try {
      final result = await dio.get('${ApiEnv.apiUrl}/doctors/$id');
      return DoctorModel.fromJson(result.data['data']);
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 404) {
        throw ServerException(e.response!.data['message']);
      }
      throw ServerException(e.toString());
    }
  }
}
