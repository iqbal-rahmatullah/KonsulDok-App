part of 'add_rating_bloc.dart';

@immutable
sealed class AddRatingState {}

final class AddRatingInitial extends AddRatingState {}

final class AddRatingLoading extends AddRatingState {}

final class AddRatingSuccess extends AddRatingState {}

final class AddRatingError extends AddRatingState {
  final String message;

  AddRatingError(this.message);
}
