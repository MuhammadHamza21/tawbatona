// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:tawbatona/app/domain/entities/person.dart';
import 'package:tawbatona/app/domain/repository/base_app_repository.dart';
import 'package:tawbatona/core/error/failures.dart';
import 'package:tawbatona/core/usecase/base_usecase.dart';

class GetPersonsUsecase extends BaseUsecase<List<Person>, NoParams> {
  final BaseAppRepository baseAppRepository;
  GetPersonsUsecase({
    required this.baseAppRepository,
  });
  @override
  Future<Either<Failure, List<Person>>> call(NoParams parameters) async {
    return await baseAppRepository.getPersons();
  }
}
