part of 'delete_favorite_bloc.dart';

@immutable
sealed class DeleteFavoriteEvent {}

final class OnDeleteFavorite extends DeleteFavoriteEvent {
  final int favoriteId;

  OnDeleteFavorite(this.favoriteId);
}
