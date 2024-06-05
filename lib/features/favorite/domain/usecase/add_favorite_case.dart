import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class AddFavoriteCase extends UseCase<void, int> {
  final FavoriteRepository repository;

  AddFavoriteCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(int params) async {
    return await repository.addFavorite(doctorId: params);
  }
}
