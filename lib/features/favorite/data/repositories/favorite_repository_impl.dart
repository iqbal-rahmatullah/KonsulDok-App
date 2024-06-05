import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/favorite/data/datasource/favorite_remote_datasource.dart';
import 'package:konsul_dok/features/favorite/domain/entities/favorite.dart';
import 'package:konsul_dok/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:konsul_dok/utils/error/exception.dart';
import 'package:konsul_dok/utils/error/failure.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource favoriteRemoteDataSource;

  FavoriteRepositoryImpl({required this.favoriteRemoteDataSource});

  @override
  Future<Either<Failure, void>> addFavorite({required int doctorId}) async {
    try {
      final response =
          await favoriteRemoteDataSource.addFavorite(doctorId: doctorId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Favorite>>> getFavorites() async {
    try {
      final result = await favoriteRemoteDataSource.getFavorites();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite({required int doctorId}) async {
    try {
      final response =
          await favoriteRemoteDataSource.removeFavorite(doctorId: doctorId);
      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } on NotFoundException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> checkFavorite({required int doctorId}) async {
    try {
      final response =
          await favoriteRemoteDataSource.checkFavorite(doctorId: doctorId);

      return Right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
