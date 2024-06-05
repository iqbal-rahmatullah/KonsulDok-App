part of 'get_favorite_bloc.dart';

@immutable
sealed class GetFavoriteEvent {}

final class OnGetFavorite extends GetFavoriteEvent {}
