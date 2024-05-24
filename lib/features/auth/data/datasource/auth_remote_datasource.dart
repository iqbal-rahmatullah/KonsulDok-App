import 'package:dio/dio.dart';
import 'package:konsul_dok/features/auth/data/models/user_model.dart';
import 'package:konsul_dok/utils/api.dart';
import 'package:konsul_dok/utils/error/exception.dart';

abstract class AuthRemoteDataSource {
  Future<String> login({
    required String email,
    required String password,
  });
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int age,
    required String gender,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);
  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post("${ApiEnv.apiUrl}/login", data: {
        "email": email,
        "password": password,
      });

      return response.data['token'];
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 401) {
        throw ServerException(e.response!.data['message']);
      } else if (e is DioException && e.response!.statusCode == 400) {
        throw ServerException(e.response!.data['message'][0]['message']);
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required int age,
    required String gender,
  }) async {
    try {
      final response = await dio.post(
        "${ApiEnv.apiUrl}/register",
        data: {
          "email": email,
          "password": password,
          "name": name,
          "no_hp": phone,
          "gender": gender,
          "age": age,
        },
      ).timeout(const Duration(seconds: 10));

      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 401) {
        throw ServerException(e.response!.data['message']);
      } else if (e is DioException && e.response!.statusCode == 400) {
        throw ServerException(e.response!.data['message'][0]['message']);
      }
      throw ServerException(e.toString());
    }
  }
}
