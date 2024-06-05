import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/favorite/domain/entities/favorite.dart';
import 'package:konsul_dok/utils/error/failure.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<Favorite>>> getFavorites();
  Future<Either<Failure, void>> addFavorite({required int doctorId});
  Future<Either<Failure, void>> removeFavorite({required int doctorId});
  Future<Either<Failure, bool>> checkFavorite({required int doctorId});
}
