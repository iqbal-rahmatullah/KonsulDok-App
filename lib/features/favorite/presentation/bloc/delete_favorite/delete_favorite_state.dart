part of 'delete_favorite_bloc.dart';

@immutable
sealed class DeleteFavoriteState {}

final class DeleteFavoriteInitial extends DeleteFavoriteState {}

final class DeleteFavoriteLoading extends DeleteFavoriteState {}

final class DeleteFavoriteSuccess extends DeleteFavoriteState {}

final class DeleteFavoriteError extends DeleteFavoriteState {
  final String message;

  DeleteFavoriteError(this.message);
}
