import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/favorite/domain/usecase/add_favorite_case.dart';
import 'package:meta/meta.dart';

part 'add_favorite_event.dart';
part 'add_favorite_state.dart';

class AddFavoriteBloc extends Bloc<AddFavoriteEvent, AddFavoriteState> {
  final AddFavoriteCase addFavoriteCase;

  AddFavoriteBloc({required this.addFavoriteCase})
      : super(AddFavoriteInitial()) {
    on<AddFavoriteEvent>((event, emit) {
      emit(AddFavoriteLoading());
    });
    on<OnAddFavorite>((event, emit) async {
      final response = await addFavoriteCase(event.doctorId);

      response.fold((l) => emit(AddFavoriteFailure(l.message)),
          (r) => emit(AddFavoriteSuccess()));
    });
  }
}
