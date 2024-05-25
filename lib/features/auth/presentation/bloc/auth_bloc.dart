import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konsul_dok/features/auth/domain/entities/user.dart';
import 'package:konsul_dok/features/auth/domain/usecase/get_user.dart';
import 'package:konsul_dok/features/auth/domain/usecase/user_save_token.dart';
import 'package:konsul_dok/features/auth/domain/usecase/user_signin.dart';
import 'package:konsul_dok/features/auth/domain/usecase/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final SaveToken _saveToken;
  final GetUser _getUser;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required SaveToken saveToken,
    required GetUser getUser,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _saveToken = saveToken,
        _getUser = getUser,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onSignIn);
    on<AuthSaveToken>(_onSavetoken);
    on<AuthGetUser>(
      (event, emit) async {
        final res = await _getUser(NoParams());
        res.fold(
          (failure) => emit(AuthFailure(message: failure.message)),
          (user) => emit(AuthSuccess(user: user)),
        );
      },
    );
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
        phone: event.phone,
        age: event.age,
        gender: event.gender,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  void _onSignIn(event, emit) async {
    final res = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (message) => emit(AuthLoginSuccess(message: message)),
    );
  }

  void _onSavetoken(event, emit) {
    _saveToken(token: event.token);
    emit(AuthSuccessSaveToken(message: "Berhasil login"));
  }
}
