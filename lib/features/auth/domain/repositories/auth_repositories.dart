import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/utils/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> loginAccount(String email, String password);
  Future<Either<Failure, String>> registerAccount(
      String email, String password);
}
