part of 'rating_bloc.dart';

@immutable
sealed class RatingState {}

final class RatingInitial extends RatingState {}

final class RatingLoading extends RatingState {}

final class RatingLoaded extends RatingState {
  final List<Rating> ratings;

  RatingLoaded(this.ratings);
}

final class RatingError extends RatingState {
  final String message;

  RatingError(this.message);
}
