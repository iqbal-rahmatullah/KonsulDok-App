import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/favorite/domain/usecase/delete_favorite_case.dart';
import 'package:meta/meta.dart';

part 'delete_favorite_event.dart';
part 'delete_favorite_state.dart';

class DeleteFavoriteBloc
    extends Bloc<DeleteFavoriteEvent, DeleteFavoriteState> {
  final DeleteFavoriteCase deleteFavoriteCase;

  DeleteFavoriteBloc({required this.deleteFavoriteCase})
      : super(DeleteFavoriteInitial()) {
    on<DeleteFavoriteEvent>((event, emit) {
      emit(DeleteFavoriteLoading());
    });
    on<OnDeleteFavorite>(
      (event, emit) async {
        final result = await deleteFavoriteCase(event.favoriteId);

        result.fold((l) => emit(DeleteFavoriteError(l.message)),
            (r) => emit(DeleteFavoriteSuccess()));
      },
    );
  }
}
