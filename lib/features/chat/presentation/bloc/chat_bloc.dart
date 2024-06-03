import 'package:bloc/bloc.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/chat/domain/usecase/add_chat.dart';
import 'package:konsul_dok/features/chat/domain/usecase/get_chat.dart';
import 'package:konsul_dok/features/chat/domain/usecase/get_detail_chat.dart';
import 'package:konsul_dok/features/chat/domain/usecase/get_message_byid.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChat _getChat;
  final AddChatCase _addChat;
  final GetDetailChatCase _getDetailChat;
  final GetMessageById _getMessageById;

  ChatBloc(
      {required GetChat getChat,
      required AddChatCase addChat,
      required GetDetailChatCase getDetailChat,
      required GetMessageById getMessageById})
      : _getDetailChat = getDetailChat,
        _getChat = getChat,
        _addChat = addChat,
        _getMessageById = getMessageById,
        super(ChatInitial()) {
    on<ChatEvent>((event, emit) {
      emit(ChatLoading());
    });
    on<GetChatsEvent>(
      (event, emit) async {
        final result = await _getChat(NoParams());
        result.fold(
          (failure) => emit(ChatError(message: failure.message)),
          (chats) {
            emit(ChatLoaded(chats: chats));
          },
        );
      },
    );
    on<AddChatEvent>(
      (event, emit) async {
        final params = AddChatParams(
          message: event.message,
          sender_id: event.sender_id,
          receive_id: event.receive_id,
        );
        final response = await _addChat(params);

        await response.fold(
          (failure) async => emit(ChatError(message: failure.message)),
          (success) async {
            final result =
                await _getMessageById(GetMessageByIdParams(chatId: success));
            result.fold(
              (failure) => emit(ChatError(message: failure.message)),
              (chats) => emit(ChatDetailLoaded(chatDetails: chats)),
            );
          },
        );
      },
    );
    on<GetDetailChatEvent>(
      (event, emit) async {
        final result = await _getDetailChat(GetDetailChatParams(
          idDoctor: event.doctorId,
        ));
        result.fold(
          (failure) => emit(ChatError(message: failure.message)),
          (chats) => emit(ChatDetailLoaded(chatDetails: chats)),
        );
      },
    );
    on<GetMessageByIdEvent>(
      (event, emit) async {
        final result = await _getMessageById(GetMessageByIdParams(
          chatId: event.chatId,
        ));
        result.fold(
          (failure) => emit(ChatError(message: failure.message)),
          (chats) => emit(ChatDetailLoaded(chatDetails: chats)),
        );
      },
    );
  }
}
