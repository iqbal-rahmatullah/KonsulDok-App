import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/chat/domain/repositories/chat_repositories.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class GetMessageById extends UseCase<List<ChatDetail>, GetMessageByIdParams> {
  final ChatRepository repository;

  GetMessageById({required this.repository});

  @override
  Future<Either<Failure, List<ChatDetail>>> call(
      GetMessageByIdParams params) async {
    return await repository.getMessageByIdChat(params.chatId);
  }
}

class GetMessageByIdParams {
  final int chatId;

  GetMessageByIdParams({required this.chatId});
}
