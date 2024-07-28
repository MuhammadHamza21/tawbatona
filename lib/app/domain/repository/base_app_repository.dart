import 'package:dartz/dartz.dart';
import 'package:tawbatona/app/domain/entities/person.dart';
import 'package:tawbatona/app/domain/usecases/update_person.dart';
import 'package:tawbatona/core/error/failures.dart';

abstract class BaseAppRepository {
  Future<Either<Failure, List<Person>>> getPersons();
  Future<Either<Failure, void>> updatePerson(UpdatingPersonParams params);
}
