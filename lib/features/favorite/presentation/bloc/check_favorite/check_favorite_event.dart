part of 'check_favorite_bloc.dart';

@immutable
sealed class CheckFavoriteEvent {}

final class OnCheckFavorite extends CheckFavoriteEvent {
  final int doctorId;

  OnCheckFavorite({required this.doctorId});
}
