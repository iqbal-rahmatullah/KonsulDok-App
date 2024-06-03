import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/rating/domain/entities/rating.dart';
import 'package:konsul_dok/features/rating/domain/repositories/rating_repository.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class GetRatingDoctorCase extends UseCase<List<Rating>, String> {
  final RatingRepository repository;

  GetRatingDoctorCase({required this.repository});

  @override
  Future<Either<Failure, List<Rating>>> call(String params) async {
    return await repository.getRatingByDoctorId(params);
  }
}
