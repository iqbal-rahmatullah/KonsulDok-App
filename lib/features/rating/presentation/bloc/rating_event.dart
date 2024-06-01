part of 'rating_bloc.dart';

@immutable
sealed class RatingEvent {}

class GetRatingByDoctorEvent extends RatingEvent {
  final String doctorId;

  GetRatingByDoctorEvent(this.doctorId);
}
