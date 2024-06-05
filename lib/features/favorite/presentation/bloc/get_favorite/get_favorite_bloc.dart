import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/favorite/domain/entities/favorite.dart';
import 'package:konsul_dok/features/favorite/domain/usecase/get_favorite_case.dart';
import 'package:konsul_dok/utils/no_params.dart';
import 'package:meta/meta.dart';

part 'get_favorite_event.dart';
part 'get_favorite_state.dart';

class GetFavoriteBloc extends Bloc<GetFavoriteEvent, GetFavoriteState> {
  final GetFavoriteCase getFavoriteCase;

  GetFavoriteBloc({required this.getFavoriteCase})
      : super(GetFavoriteInitial()) {
    on<GetFavoriteEvent>((event, emit) {
      emit(GetFavoriteLoading());
    });
    on<OnGetFavorite>((event, emit) async {
      final response = await getFavoriteCase(NoParams());

      response.fold((l) => emit(GetFavoriteFailure(l.message)),
          (r) => emit(GetFavoriteSuccess(favorites: r)));
    });
  }
}
