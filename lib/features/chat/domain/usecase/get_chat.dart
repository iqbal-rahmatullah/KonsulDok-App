import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/features/chat/domain/repositories/chat_repositories.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class GetChat extends UseCase<List<Chat>, NoParams> {
  final ChatRepository chatRepository;

  GetChat({required this.chatRepository});

  @override
  Future<Either<Failure, List<Chat>>> call(NoParams params) async {
    return await chatRepository.getChats();
  }
}

class NoParams {}
