import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:konsul_dok/features/auth/data/models/user_model.dart';
import 'package:konsul_dok/features/auth/domain/entities/user.dart';
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
  Future<UserModel> getUser();
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<User> editProfile({
    required String name,
    required String phone,
    required int age,
    required String email,
    required String gender,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final Box<String> box;

  AuthRemoteDataSourceImpl(this.dio, this.box);
  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post("${ApiEnv.apiUrl}/login", data: {
        "email": email,
        "password": password,
      }).timeout(const Duration(seconds: 10));

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
          "name": name,
          "email": email,
          "password": password,
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

  @override
  Future<UserModel> getUser() async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio
          .get(
            "${ApiEnv.apiUrl}/users",
            options: Options(
              headers: {
                'Authorization': session,
              },
            ),
          )
          .timeout(const Duration(seconds: 10));

      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio.put('${ApiEnv.apiUrl}/users/change-password',
          options: Options(
            headers: {
              'Authorization': session,
            },
          ),
          data: {
            "last_password": oldPassword,
            "password": newPassword,
          }).timeout(const Duration(seconds: 10));
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
  Future<User> editProfile(
      {required String name,
      required String phone,
      required int age,
      required String email,
      required String gender}) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio.put(
        '${ApiEnv.apiUrl}/users',
        options: Options(
          headers: {
            'Authorization': session,
          },
        ),
        data: {
          "name": name,
          "email": email,
          "no_hp": phone,
          "age": age,
          "gender": gender,
        },
      ).timeout(const Duration(seconds: 10));

      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 409) {
        throw ServerException(e.response!.data['message']);
      } else if (e is DioException && e.response!.statusCode == 400) {
        throw ServerException(e.response!.data['message'][0]['message']);
      }
      throw ServerException(e.toString());
    }
  }
}
