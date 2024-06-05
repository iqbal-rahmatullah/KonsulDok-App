import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/favorite/domain/entities/favorite.dart';
import 'package:konsul_dok/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/no_params.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class GetFavoriteCase extends UseCase<List<Favorite>, NoParams> {
  final FavoriteRepository repository;

  GetFavoriteCase({required this.repository});

  @override
  Future<Either<Failure, List<Favorite>>> call(NoParams params) async {
    return await repository.getFavorites();
  }
}
