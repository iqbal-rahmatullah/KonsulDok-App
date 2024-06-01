part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess({required this.user});
}

final class AuthLoginSuccess extends AuthState {
  final String message;

  AuthLoginSuccess({required this.message});
}

final class AuthGetUserSuccess extends AuthState {
  final User user;

  AuthGetUserSuccess({required this.user});
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});
}

final class AuthRegisterFailed extends AuthState {
  final String message;

  AuthRegisterFailed({required this.message});
}

final class AuthSuccessSaveToken extends AuthState {
  final String message;

  AuthSuccessSaveToken({required this.message});
}

final class AuthLogoutSuccess extends AuthState {}

final class AuthChangePasswordSucces extends AuthState {}

final class AuthChangePasswordFailed extends AuthState {
  final String message;

  AuthChangePasswordFailed({required this.message});
}
