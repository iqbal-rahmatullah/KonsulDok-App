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
