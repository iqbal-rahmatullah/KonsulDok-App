part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final int age;
  final String gender;

  AuthSignUp(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone,
      required this.age,
      required this.gender});
}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  AuthSignIn({required this.email, required this.password});
}

final class AuthSaveToken extends AuthEvent {
  final String token;

  AuthSaveToken({required this.token});
}

final class AuthGetUser extends AuthEvent {}

final class AuthLogout extends AuthEvent {}

final class AuthChangePasswordEvent extends AuthEvent {
  final String oldPassword;
  final String newPassword;

  AuthChangePasswordEvent(
      {required this.oldPassword, required this.newPassword});
}

final class AuthEditProfileEvent extends AuthEvent {
  final String name;
  final String phone;
  final int age;
  final String email;
  final String gender;

  AuthEditProfileEvent(
      {required this.name,
      required this.phone,
      required this.age,
      required this.email,
      required this.gender});
}
