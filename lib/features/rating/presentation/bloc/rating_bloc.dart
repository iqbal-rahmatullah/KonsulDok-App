import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/rating/domain/entities/rating.dart';
import 'package:konsul_dok/features/rating/domain/usecase/get_rating_doctor.dart';
import 'package:meta/meta.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final GetRatingDoctorCase getRatingDoctorCase;

  RatingBloc({required this.getRatingDoctorCase}) : super(RatingInitial()) {
    on<RatingEvent>((event, emit) {
      emit(RatingLoading());
    });
    on<GetRatingByDoctorEvent>((event, emit) async {
      final result = await getRatingDoctorCase(event.doctorId);
      result.fold(
        (failure) => emit(RatingError(failure.message)),
        (ratings) => emit(RatingLoaded(ratings)),
      );
    });
  }
}
