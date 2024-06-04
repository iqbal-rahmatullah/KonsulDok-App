import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/chat/domain/usecase/get_detail_chat.dart';
import 'package:meta/meta.dart';

part 'get_chat_doctor_event.dart';
part 'get_chat_doctor_state.dart';

class GetChatDoctorBloc extends Bloc<GetChatDoctorEvent, GetChatDoctorState> {
  final GetDetailChatCase getDetailChat;

  GetChatDoctorBloc({required this.getDetailChat})
      : super(GetChatDoctorInitial()) {
    on<GetChatDoctorEvent>((event, emit) {
      emit(GetChatDoctorLoading());
    });

    on<GetChatDoctorAction>(
      (event, emit) async {
        final result = await getDetailChat(GetDetailChatParams(
          idDoctor: event.doctorId,
        ));
        result.fold(
          (failure) => emit(GetChatDoctorError(message: failure.message)),
          (chats) => emit(GetChatDoctorLoaded(chatDetails: chats)),
        );
      },
    );
  }
}
