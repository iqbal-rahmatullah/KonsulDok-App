import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:konsul_dok/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:konsul_dok/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:konsul_dok/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:konsul_dok/features/auth/domain/repositories/auth_repositories.dart';
import 'package:konsul_dok/features/auth/domain/usecase/get_user.dart';
import 'package:konsul_dok/features/auth/domain/usecase/user_save_token.dart';
import 'package:konsul_dok/features/auth/domain/usecase/user_signin.dart';
import 'package:konsul_dok/features/auth/domain/usecase/user_signup.dart';
import 'package:konsul_dok/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:konsul_dok/features/dashboard/cubit/navbar_cubit.dart';
import 'package:konsul_dok/features/doctor/data/datasource/doctor_remote_data_source.dart';
import 'package:konsul_dok/features/doctor/data/repositories/doctor_repository_impl.dart';
import 'package:konsul_dok/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:konsul_dok/features/doctor/domain/usecase/get_doctor_by_category.dart';
import 'package:konsul_dok/features/doctor/domain/usecase/get_doctor_by_id.dart';
import 'package:konsul_dok/features/doctor/presentation/bloc/doctor_bloc.dart';
import 'package:path_provider/path_provider.dart' as path;

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initDoctor();

  final Dio dio = Dio();
  serviceLocator.registerLazySingleton(() => dio);

  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Box<String> sessionBox = await Hive.openBox<String>('session');
  // sessionBox.clear();
  serviceLocator.registerLazySingleton(() => sessionBox);
  serviceLocator.registerLazySingleton(() => NavbarCubit());
}

void _initDoctor() {
  serviceLocator
    ..registerFactory<DoctorRemoteDataSource>(
      () => DoctorRemoteDataSourceImpl(
        dio: serviceLocator(),
      ),
    )
    ..registerFactory<DoctorRepository>(
      () => DoctorRepoSitoryImpl(
        doctorRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetDoctorByCategory(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetDoctorById(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => DoctorBloc(
        getDoctorByCategory: serviceLocator(),
        getDoctorById: serviceLocator(),
      ),
    );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(box: serviceLocator()))
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SaveToken(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetUser(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        saveToken: serviceLocator(),
        getUser: serviceLocator(),
      ),
    );
}
