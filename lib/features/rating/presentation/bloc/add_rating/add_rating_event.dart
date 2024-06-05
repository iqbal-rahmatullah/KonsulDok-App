part of 'add_rating_bloc.dart';

@immutable
sealed class AddRatingEvent {}

final class OnAddRating extends AddRatingEvent {
  final int appointmentId;
  final int rating;

  OnAddRating(this.appointmentId, this.rating);
}
