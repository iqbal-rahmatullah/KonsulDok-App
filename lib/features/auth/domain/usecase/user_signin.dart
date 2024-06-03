import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/auth/domain/repositories/auth_repositories.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class UserSignIn extends UseCase<String, UserSignInParams> {
  final AuthRepository repository;

  UserSignIn({required this.repository});

  @override
  Future<Either<Failure, String>> call(UserSignInParams params) async {
    return await repository.loginAccount(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
