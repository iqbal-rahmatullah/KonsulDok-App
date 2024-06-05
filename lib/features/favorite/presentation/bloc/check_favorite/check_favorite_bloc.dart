import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/favorite/domain/usecase/check_favorite_case.dart';
import 'package:meta/meta.dart';

part 'check_favorite_event.dart';
part 'check_favorite_state.dart';

class CheckFavoriteBloc extends Bloc<CheckFavoriteEvent, CheckFavoriteState> {
  final CheckFavoriteCase checkFavoriteCase;

  CheckFavoriteBloc({required this.checkFavoriteCase})
      : super(CheckFavoriteInitial()) {
    on<CheckFavoriteEvent>((event, emit) {
      emit(CheckFavoriteLoading());
    });
    on<OnCheckFavorite>((event, emit) async {
      final response = await checkFavoriteCase(event.doctorId);
      response.fold(
        (l) => emit(CheckFavoriteError(message: l.message)),
        (r) {
          emit(CheckFavoriteSuccess(isFavorite: r));
        },
      );
    });
  }
}
