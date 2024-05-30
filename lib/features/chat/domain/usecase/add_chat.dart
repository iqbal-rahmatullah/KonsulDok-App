import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/chat/domain/repositories/chat_repositories.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class AddChatCase extends UseCase<void, AddChatParams> {
  final ChatRepository repository;

  AddChatCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AddChatParams params) async {
    return await repository.addChat(
      message: params.message,
      sender_id: params.sender_id,
      receive_id: params.receive_id,
    );
  }
}

class AddChatParams {
  final String message;
  final int sender_id;
  final int receive_id;

  AddChatParams(
      {required this.message,
      required this.sender_id,
      required this.receive_id});
}
