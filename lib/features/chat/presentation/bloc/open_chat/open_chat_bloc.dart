import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/chat/domain/usecase/open_chat.dart';
import 'package:meta/meta.dart';

part 'open_chat_event.dart';
part 'open_chat_state.dart';

class OpenChatBloc extends Bloc<OpenChatEvent, OpenChatState> {
  final OpenChat openChat;

  OpenChatBloc({required this.openChat}) : super(OpenChatInitial()) {
    on<OpenChatEvent>((event, emit) {
      emit(OpenChatLoading());
    });
    on<OnOpenChat>((event, emit) async {
      final result = await openChat(event.receiverId);
      result.fold((failure) {
        emit(OpenChatFailure(message: failure.message));
      }, (success) {
        emit(OpenChatSuccess(idChat: success));
      });
    });
  }
}
