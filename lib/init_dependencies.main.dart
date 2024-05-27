part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initDoctor();
  _initAppointment();

  final Dio dio = Dio();
  serviceLocator.registerLazySingleton(() => dio);

  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Box<String> sessionBox = await Hive.openBox<String>('session');
  // sessionBox.clear();
  serviceLocator.registerLazySingleton(() => sessionBox);
  serviceLocator.registerLazySingleton(() => NavbarCubit());
  serviceLocator.registerLazySingleton(() => NavbarDoctorCubit());
}

void _initAppointment() {
  serviceLocator
    ..registerFactory<AppointmentRemoteDataSource>(
        () => AppointmentRemoteDataSourceImpl(dio: serviceLocator()))
    ..registerFactory<AppointmentRepository>(
      () => AppointmentRepositoryImpl(
        appointmentRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CreateAppointment(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAppointmentPatient(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AppointmentBloc(
        createAppointment: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
        () => AppointmentPatientBloc(getAppointmentPatient: serviceLocator()));
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
