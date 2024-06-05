import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class CheckFavoriteCase extends UseCase<bool, int> {
  final FavoriteRepository repository;

  CheckFavoriteCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(int params) async {
    return await repository.checkFavorite(doctorId: params);
  }
}
