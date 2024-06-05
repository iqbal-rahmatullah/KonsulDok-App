import 'package:fpdart/src/either.dart';
import 'package:konsul_dok/features/chat/domain/repositories/chat_repositories.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class OpenChat implements UseCase<int, int> {
  final ChatRepository repository;

  OpenChat({required this.repository});

  @override
  Future<Either<Failure, int>> call(int params) async {
    return await repository.openChat(receiverId: params);
  }
}
