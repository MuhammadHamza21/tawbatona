// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:tawbatona/app/data/data_source/app_remote_datasource.dart';
import 'package:tawbatona/app/domain/entities/person.dart';
import 'package:tawbatona/app/domain/repository/base_app_repository.dart';
import 'package:tawbatona/app/domain/usecases/add_person.dart';
import 'package:tawbatona/app/domain/usecases/update_person.dart';
import 'package:tawbatona/core/constants/app_constants.dart';
import 'package:tawbatona/core/error/exceptions.dart';
import 'package:tawbatona/core/error/failures.dart';
import 'package:tawbatona/core/network/network_info.dart';

class AppRepository extends BaseAppRepository {
  final BaseNetworkInfo baseNetworkInfo;
  final BaseAppRemoteDatasource baseAppRemoteDatasource;
  AppRepository({
    required this.baseNetworkInfo,
    required this.baseAppRemoteDatasource,
  });
  @override
  Future<Either<Failure, List<Person>>> getPersons() async {
    if (await baseNetworkInfo.isConnected) {
      try {
        var result = await baseAppRemoteDatasource.getPersons();
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
  Future<Either<Failure, void>> updatePerson(
      UpdatingPersonParams params) async {
    if (await baseNetworkInfo.isConnected) {
      try {
        var result = await baseAppRemoteDatasource.updatePerson(params);
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
  Future<Either<Failure, void>> addPersons(AddingPersonParams params) async {
    if (await baseNetworkInfo.isConnected) {
      try {
        var result = await baseAppRemoteDatasource.addPersons(params);
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
  Future<Either<Failure, void>> deletePerson(String id) async {
    if (await baseNetworkInfo.isConnected) {
      try {
        var result = await baseAppRemoteDatasource.deletePerson(id);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.message));
      }
    } else {
      return const Left(
          OfflineFailure(message: AppConstants.offlineErrorMessage));
    }
  }
}
