import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:konsul_dok/features/favorite/data/model/favorite_model.dart';
import 'package:konsul_dok/utils/api.dart';
import 'package:konsul_dok/utils/error/exception.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<FavoriteModel>> getFavorites();
  Future<void> addFavorite({required int doctorId});
  Future<void> removeFavorite({required int doctorId});
  Future<bool> checkFavorite({required int doctorId});
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final Dio dio;
  final Box<String> box;

  FavoriteRemoteDataSourceImpl({required this.dio, required this.box});

  @override
  Future<void> addFavorite({required int doctorId}) async {
    try {
      final response = await dio.post(
        '${ApiEnv.apiUrl}/favorite',
        data: {
          'doctor_id': doctorId,
        },
        options: Options(
          headers: {
            'Authorization': box.get('token'),
          },
        ),
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio.get(
        '${ApiEnv.apiUrl}/favorite',
        options: Options(
          headers: {
            'Authorization': session,
          },
        ),
      );

      return (response.data['data'] as List)
          .map((e) => FavoriteModel.fromJson(e))
          .toList();
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 404) {
        return [];
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> removeFavorite({required int doctorId}) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      await dio.delete(
        '${ApiEnv.apiUrl}/favorite',
        data: {
          'doctor_id': doctorId,
        },
        options: Options(
          headers: {
            'Authorization': session,
          },
        ),
      );
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 404) {
        throw NotFoundException("Favorite not found");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> checkFavorite({required int doctorId}) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio.get(
        '${ApiEnv.apiUrl}/favorite/check',
        data: {
          'doctor_id': doctorId,
        },
        options: Options(
          headers: {
            'Authorization': session,
          },
        ),
      );

      return response.data;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
