import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/chat/domain/repositories/chat_repositories.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class GetDetailChatCase extends UseCase<List<ChatDetail>, GetDetailChatParams> {
  final ChatRepository chatRepository;

  GetDetailChatCase({required this.chatRepository});

  @override
  Future<Either<Failure, List<ChatDetail>>> call(
      GetDetailChatParams params) async {
    return await chatRepository.getChatDetail(params.idDoctor);
  }
}

class GetDetailChatParams {
  final int idDoctor;

  GetDetailChatParams({required this.idDoctor});
}
