import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/utils/error/failure.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<Chat>>> getChats();
}
