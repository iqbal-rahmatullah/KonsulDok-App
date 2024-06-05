import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/rating/domain/entities/rating.dart';
import 'package:konsul_dok/utils/error/failure.dart';

abstract class RatingRepository {
  Future<Either<Failure, List<Rating>>> getRatingByDoctorId(String doctorId);
  Future<Either<Failure, bool>> checkRatingAppointmet(int appointmentId);
  Future<Either<Failure, void>> addRating(int appointmentId, int rating);
}
