import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:konsul_dok/features/rating/data/model/rating_model.dart';
import 'package:konsul_dok/utils/api.dart';
import 'package:konsul_dok/utils/error/exception.dart';

abstract class RatingRemoteDataSource {
  Future<List<RatingModel>> getRatingByDoctorId(String doctorId);
  Future<bool> checkRatingAppointmet(int appointmentId);
  Future<void> addRating(int appointmentId, int rating);
}

class RatingRemoteDataSourceImpl implements RatingRemoteDataSource {
  final Dio dio;
  final Box<String> box;

  RatingRemoteDataSourceImpl({required this.dio, required this.box});

  @override
  Future<List<RatingModel>> getRatingByDoctorId(String doctorId) async {
    try {
      final response = await dio.get(
        '${ApiEnv.apiUrl}/doctors/$doctorId',
      );

      List<RatingModel> ratings = [];
      for (var item in response.data['data']['rating']) {
        ratings.add(RatingModel.fromJson(item));
      }

      return ratings;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> checkRatingAppointmet(int appointmentId) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio.get(
        '${ApiEnv.apiUrl}/ratings/check/$appointmentId',
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

  @override
  Future<void> addRating(int appointmentId, int rating) async {
    try {
      final session = box.get('token');

      if (session == null) {
        throw AuthException("Token not found");
      }

      final response = await dio.post(
        '${ApiEnv.apiUrl}/ratings',
        data: {
          'appointment_id': appointmentId,
          'rating': rating,
        },
        options: Options(
          headers: {
            'Authorization': session,
          },
        ),
      );
    } catch (e) {
      if (e is DioException && e.response!.statusCode == 401) {
        throw AuthException(e.response!.data['message']);
      }
      throw ServerException(e.toString());
    }
  }
}
