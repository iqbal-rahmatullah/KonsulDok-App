import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/features/chat/domain/usecase/get_chat.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  GetChat _getChat;

  ChatBloc({required GetChat getChat})
      : _getChat = getChat,
        super(ChatInitial()) {
    on<ChatEvent>((event, emit) {
      emit(ChatLoading());
    });
    on<GetChatsEvent>(
      (event, emit) async {
        final result = await _getChat(NoParams());
        result.fold(
          (failure) => emit(ChatError(message: failure.message)),
          (chats) => emit(ChatLoaded(chats: chats)),
        );
      },
    );
  }
}
