// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:tawbatona/app/domain/repository/base_app_repository.dart';
import 'package:tawbatona/core/error/failures.dart';
import 'package:tawbatona/core/usecase/base_usecase.dart';

class DeletePersonUsecase extends BaseUsecase<void, String> {
  final BaseAppRepository baseAppRepository;
  DeletePersonUsecase({
    required this.baseAppRepository,
  });
  @override
  Future<Either<Failure, void>> call(String parameters) async {
    return await baseAppRepository.deletePerson(parameters);
  }
}
