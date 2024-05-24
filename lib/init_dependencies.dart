import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:konsul_dok/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:konsul_dok/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:konsul_dok/features/auth/domain/repositories/auth_repositories.dart';
import 'package:konsul_dok/features/auth/domain/usecase/user_signup.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  final Dio dio = Dio();
  serviceLocator.registerLazySingleton(() => dio);
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
      ),
    );
}
