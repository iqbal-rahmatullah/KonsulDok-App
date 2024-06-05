part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initDoctor();
  _initAppointment();
  _initRating();
  _initChat();

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

void _initChat() {
  serviceLocator
    ..registerFactory<ChatRemoteDataSource>(() =>
        ChatRemoteDataSourceImpl(dio: serviceLocator(), box: serviceLocator()))
    ..registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(
        remoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(() => GetChat(chatRepository: serviceLocator()))
    ..registerFactory(
      () => AddChatCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetDetailChatCase(
        chatRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetMessageById(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => OpenChat(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ChatBloc(
        getChat: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => GetChatDoctorBloc(
        getDetailChat: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AddChatBloc(
        addChat: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => MessageByIdBloc(
        getMessageById: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => OpenChatBloc(
        openChat: serviceLocator(),
      ),
    );
}

void _initAppointment() {
  serviceLocator
    ..registerFactory<AppointmentRemoteDataSource>(
      () => AppointmentRemoteDataSourceImpl(
        dio: serviceLocator(),
        box: serviceLocator(),
      ),
    )
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
    ..registerFactory(
      () => GetAppointmentDoctor(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetClockAppointmentCase(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AppointmentBloc(
        createAppointment: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AppointmentPatientBloc(
          getAppointmentPatient: serviceLocator(),
          getAppointmentDoctor: serviceLocator()),
    )
    ..registerLazySingleton(
      () => ClockAppointmentBloc(
        getClockAppointment: serviceLocator(),
      ),
    );
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

void _initRating() {
  serviceLocator
    ..registerFactory<RatingRemoteDataSource>(
      () => RatingRemoteDataSourceImpl(
        dio: serviceLocator(),
        box: serviceLocator(),
      ),
    )
    ..registerFactory<RatingRepository>(
      () => RatingRepositoryImpl(
        ratingRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetRatingDoctorCase(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => RatingBloc(
        getRatingDoctorCase: serviceLocator(),
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
    ..registerFactory(
      () => ChangePasswordCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => EditProfileCase(
        repository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        saveToken: serviceLocator(),
        getUser: serviceLocator(),
        authLocalDataSource: serviceLocator(),
        changePasswordCase: serviceLocator(),
        editProfileCase: serviceLocator(),
      ),
    );
}
