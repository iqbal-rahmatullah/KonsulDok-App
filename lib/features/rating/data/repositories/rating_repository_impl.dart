import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/rating/data/datasource/rating_remote_datasource.dart';
import 'package:konsul_dok/features/rating/domain/entities/rating.dart';
import 'package:konsul_dok/features/rating/domain/repositories/rating_repository.dart';
import 'package:konsul_dok/utils/error/exception.dart';
import 'package:konsul_dok/utils/error/failure.dart';

class RatingRepositoryImpl implements RatingRepository {
  final RatingRemoteDataSource ratingRemoteDataSource;

  RatingRepositoryImpl({required this.ratingRemoteDataSource});

  @override
  Future<Either<Failure, List<Rating>>> getRatingByDoctorId(
      String doctorId) async {
    try {
      final ratings =
          await ratingRemoteDataSource.getRatingByDoctorId(doctorId);
      return Right(ratings);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> checkRatingAppointmet(int appointmentId) async {
    try {
      final isRated =
          await ratingRemoteDataSource.checkRatingAppointmet(appointmentId);
      return Right(isRated);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addRating(int appointmentId, int rating) async {
    try {
      final response =
          await ratingRemoteDataSource.addRating(appointmentId, rating);
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
