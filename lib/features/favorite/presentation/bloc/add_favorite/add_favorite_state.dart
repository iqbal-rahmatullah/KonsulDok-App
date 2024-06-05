part of 'add_favorite_bloc.dart';

@immutable
sealed class AddFavoriteState {}

final class AddFavoriteInitial extends AddFavoriteState {}

final class AddFavoriteLoading extends AddFavoriteState {}

final class AddFavoriteSuccess extends AddFavoriteState {}

final class AddFavoriteFailure extends AddFavoriteState {
  final String message;

  AddFavoriteFailure(this.message);
}
