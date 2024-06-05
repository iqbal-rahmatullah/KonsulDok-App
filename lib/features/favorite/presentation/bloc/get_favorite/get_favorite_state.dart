part of 'get_favorite_bloc.dart';

@immutable
sealed class GetFavoriteState {}

final class GetFavoriteInitial extends GetFavoriteState {}

final class GetFavoriteLoading extends GetFavoriteState {}

final class GetFavoriteSuccess extends GetFavoriteState {
  final List<Favorite> favorites;

  GetFavoriteSuccess({required this.favorites});
}

final class GetFavoriteFailure extends GetFavoriteState {
  final String message;

  GetFavoriteFailure(this.message);
}
