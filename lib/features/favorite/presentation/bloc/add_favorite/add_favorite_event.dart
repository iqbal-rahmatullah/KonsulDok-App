part of 'add_favorite_bloc.dart';

@immutable
sealed class AddFavoriteEvent {}

class OnAddFavorite extends AddFavoriteEvent {
  final int doctorId;

  OnAddFavorite(this.doctorId);
}
