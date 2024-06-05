import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/rating/domain/repositories/rating_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class CheckRatingAppointmentCase extends UseCase<bool, int> {
  final RatingRepository repository;

  CheckRatingAppointmentCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(int params) async {
    return await repository.checkRatingAppointmet(params);
  }
}
