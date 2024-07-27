// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tawbatona/authentication/data/data_source/auth_remote_datasource.dart';

import 'package:tawbatona/authentication/domain/repository/base_auth_repository.dart';
import 'package:tawbatona/authentication/domain/usecases/create_user_with_email_and_password.dart';
import 'package:tawbatona/authentication/domain/usecases/save_user_data.dart';
import 'package:tawbatona/authentication/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:tawbatona/core/constants/app_constants.dart';
import 'package:tawbatona/core/error/exceptions.dart';
import 'package:tawbatona/core/error/failures.dart';
import 'package:tawbatona/core/network/network_info.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  final BaseNetworkInfo baseNetworkInfo;
  final BaseAuthenticationRemoteDatasource baseAuthenticationRemoteDatasource;
  AuthenticationRepository({
    required this.baseNetworkInfo,
    required this.baseAuthenticationRemoteDatasource,
  });
  @override
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
      SignInParams parameters) async {
    if (await baseNetworkInfo.isConnected) {
      try {
        var result = await baseAuthenticationRemoteDatasource
            .signInWithEmailAndPassword(parameters);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.message));
      }
    } else {
      return const Left(
          OfflineFailure(message: AppConstants.offlineErrorMessage));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> createUserWithEmailAndPassword(
      CreateUserParams params) async {
    if (await baseNetworkInfo.isConnected) {
      try {
        var result = await baseAuthenticationRemoteDatasource
            .createUserWithEmailAndPassword(params);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(
          ServerFailure(message: failure.message),
        );
      }
    } else {
      return const Left(
          OfflineFailure(message: AppConstants.offlineErrorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserData(UserDataParams user) async {
    if (await baseNetworkInfo.isConnected) {
      await baseAuthenticationRemoteDatasource.saveUserData(user);
      return Right(() {});
    } else {
      return const Left(
          OfflineFailure(message: AppConstants.offlineErrorMessage));
    }
  }

  @override
  User? getCurrentUser() {
    return baseAuthenticationRemoteDatasource.getCurrentUser();
  }
}
