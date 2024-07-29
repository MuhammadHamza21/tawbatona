import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tawbatona/app/data/data_source/app_remote_datasource.dart';
import 'package:tawbatona/app/data/repository/app_repository.dart';
import 'package:tawbatona/app/domain/repository/base_app_repository.dart';
import 'package:tawbatona/app/domain/usecases/add_person.dart';
import 'package:tawbatona/app/domain/usecases/delete_person.dart';
import 'package:tawbatona/app/domain/usecases/get_persons.dart';
import 'package:tawbatona/app/domain/usecases/update_person.dart';
import 'package:tawbatona/app/presentation/controller/app_cubit.dart';
import 'package:tawbatona/authentication/data/data_source/auth_remote_datasource.dart';
import 'package:tawbatona/authentication/data/repository/auth_repository.dart';
import 'package:tawbatona/authentication/domain/repository/base_auth_repository.dart';
import 'package:tawbatona/authentication/domain/usecases/create_user_with_email_and_password.dart';
import 'package:tawbatona/authentication/domain/usecases/gt_current_user.dart';
import 'package:tawbatona/authentication/domain/usecases/save_user_data.dart';
import 'package:tawbatona/authentication/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:tawbatona/authentication/presentation/controller/authentication_cubit.dart';
import 'package:tawbatona/core/network/network_info.dart';
import 'package:tawbatona/core/services/notifications/notification_services.dart';

var sl = GetIt.instance;

class ServiceLocator {
  static Future init() async {
    // bloc
    sl.registerFactory(() => AuthenticationCubit(sl(), sl(), sl(), sl()));
    sl.registerFactory(() => AppCubit(sl(), sl(), sl(), sl()));
    // data sources
    sl.registerLazySingleton<BaseAuthenticationRemoteDatasource>(
        () => AuthenticationRemoteDatasource());
    sl.registerLazySingleton<BaseAppRemoteDatasource>(
        () => AppRemoteDatasource());
    // repositories
    sl.registerLazySingleton<BaseAuthenticationRepository>(() =>
        AuthenticationRepository(
            baseNetworkInfo: sl(), baseAuthenticationRemoteDatasource: sl()));
    sl.registerLazySingleton<BaseAppRepository>(() =>
        AppRepository(baseNetworkInfo: sl(), baseAppRemoteDatasource: sl()));
    // usecases
    sl.registerLazySingleton(() => CreateUserWithEmailAndPasswordUsecase(
        baseAuthenticationRepository: sl()));
    sl.registerLazySingleton(
        () => GetCurrentUserUsecase(baseAuthenticationRepository: sl()));
    sl.registerLazySingleton(() =>
        SignInWithEmailAndPasswordUsecase(baseAuthenticationRepository: sl()));
    sl.registerLazySingleton(
        () => SaveUserDataUsecase(baseAuthenticationRepository: sl()));
    sl.registerLazySingleton(() => AddPersonUsecase(baseAppRepository: sl()));
    sl.registerLazySingleton(() => GetPersonsUsecase(baseAppRepository: sl()));
    sl.registerLazySingleton(
        () => UpdatePersonUsecase(baseAppRepository: sl()));
    sl.registerLazySingleton(
        () => DeletePersonUsecase(baseAppRepository: sl()));
    // external
    NotificationServices().firebaseInitialize();
    await Firebase.initializeApp();
    sl.registerLazySingleton(() => InternetConnectionChecker());
    sl.registerLazySingleton<BaseNetworkInfo>(
        () => NetworkInfo(internetConnectionChecker: sl()));
  }
}
