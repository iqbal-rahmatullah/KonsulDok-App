import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/utils/error/failure.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Chat>>> getChats();
  Future<Either<Failure, void>> addChat({
    required String message,
    required int sender_id,
    required int receive_id,
  });
  Future<Either<Failure, List<ChatDetail>>> getChatDetail(int doctorId);
  Future<Either<Failure, List<ChatDetail>>> getMessageByIdChat(int chatId);
}
