import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:konsul_dok/features/rating/data/model/rating_model.dart';
import 'package:konsul_dok/utils/api.dart';
import 'package:konsul_dok/utils/error/exception.dart';

abstract class RatingRemoteDataSource {
  Future<List<RatingModel>> getRatingByDoctorId(String doctorId);
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
}
