// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:tawbatona/app/domain/repository/base_app_repository.dart';
import 'package:tawbatona/core/error/failures.dart';
import 'package:tawbatona/core/usecase/base_usecase.dart';

class UpdatePersonUsercase extends BaseUsecase<void, UpdatingPersonParams> {
  final BaseAppRepository baseAppRepository;
  UpdatePersonUsercase({
    required this.baseAppRepository,
  });
  @override
  Future<Either<Failure, void>> call(UpdatingPersonParams parameters) async {
    return await baseAppRepository.updatePerson(parameters);
  }
}

class UpdatingPersonParams extends Equatable {
  final String id;
  final int noOfBadWords;
  const UpdatingPersonParams({
    required this.id,
    required this.noOfBadWords,
  });
  @override
  List<Object?> get props => [id, noOfBadWords];
}
