part of 'check_favorite_bloc.dart';

@immutable
sealed class CheckFavoriteState {}

final class CheckFavoriteInitial extends CheckFavoriteState {}

final class CheckFavoriteLoading extends CheckFavoriteState {}

final class CheckFavoriteSuccess extends CheckFavoriteState {
  final bool isFavorite;

  CheckFavoriteSuccess({required this.isFavorite});
}

final class CheckFavoriteError extends CheckFavoriteState {
  final String message;

  CheckFavoriteError({required this.message});
}
