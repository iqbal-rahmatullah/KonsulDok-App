import 'package:fpdart/fpdart.dart';
import 'package:konsul_dok/features/auth/domain/repositories/auth_repositories.dart';
import 'package:konsul_dok/utils/error/failure.dart';
import 'package:konsul_dok/utils/usecase/usecase.dart';

class ChangePasswordCase implements UseCase<void, ChangePasswordParams> {
  final AuthRepository repository;

  ChangePasswordCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) async {
    return await repository.changePassword(
        newPassword: params.newPassword, oldPassword: params.oldPassword);
  }
}

class ChangePasswordParams {
  final String oldPassword;
  final String newPassword;

  ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
  });
}
