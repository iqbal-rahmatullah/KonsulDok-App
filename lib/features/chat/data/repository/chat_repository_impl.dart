import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:konsul_dok/features/chat/domain/entities/chat.dart';
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
}
