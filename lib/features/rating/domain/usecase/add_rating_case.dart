import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/rating/domain/repositories/rating_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class AddRatingCase extends UseCase<void, AddRatingParams> {
  final RatingRepository repository;

  AddRatingCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(AddRatingParams params) async {
    return await repository.addRating(params.appointmentId, params.rating);
  }
}

class AddRatingParams {
  final int appointmentId;
  final int rating;

  AddRatingParams({required this.appointmentId, required this.rating});
}
