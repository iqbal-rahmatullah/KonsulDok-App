import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat_detail.dart';
import 'package:konsul_dok/features/chat/domain/repositories/chat_repositories.dart';
import 'package:konsul_dok/utils/error/exception.dart';
import 'package:konsul_dok/utils/error/failure.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Chat>>> getChats() async {
    try {
      final result = await remoteDataSource.getChats();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> addChat(
      {required String message,
      required int sender_id,
      required int receive_id}) async {
    try {
      await remoteDataSource.addChat(
        message: message,
        sender_id: sender_id,
        receive_id: receive_id,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ChatDetail>>> getChatDetail(int doctorId) async {
    try {
      final result = await remoteDataSource.getChatDetail(doctorId);
      return Right(result);
    } on NotFoundException catch (_) {
      return const Right([]);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<ChatDetail>>> getMessageByIdChat(
      int chatId) async {
    try {
      final result = await remoteDataSource.getMessageByIdChat(chatId);
      return Right(result);
    } on NotFoundException catch (_) {
      return const Right([]);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
