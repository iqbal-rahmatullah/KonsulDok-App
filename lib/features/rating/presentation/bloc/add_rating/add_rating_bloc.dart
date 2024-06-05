import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/rating/domain/usecase/add_rating_case.dart';
import 'package:meta/meta.dart';

part 'add_rating_event.dart';
part 'add_rating_state.dart';

class AddRatingBloc extends Bloc<AddRatingEvent, AddRatingState> {
  final AddRatingCase addRatingCase;

  AddRatingBloc({required this.addRatingCase}) : super(AddRatingInitial()) {
    on<AddRatingEvent>((event, emit) {
      emit(AddRatingLoading());
    });
    on<OnAddRating>((event, emit) async {
      final response = await addRatingCase(AddRatingParams(
          appointmentId: event.appointmentId, rating: event.rating));

      response.fold(
        (l) => emit(AddRatingError(l.message)),
        (r) => emit(
          AddRatingSuccess(),
        ),
      );
    });
  }
}
