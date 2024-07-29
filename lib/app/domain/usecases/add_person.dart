// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:tawbatona/app/domain/repository/base_app_repository.dart';
import 'package:tawbatona/core/error/failures.dart';
import 'package:tawbatona/core/usecase/base_usecase.dart';

class AddPersonUsecase extends BaseUsecase<void, AddingPersonParams> {
  final BaseAppRepository baseAppRepository;
  AddPersonUsecase({
    required this.baseAppRepository,
  });
  @override
  Future<Either<Failure, void>> call(AddingPersonParams parameters) async {
    return await baseAppRepository.addPersons(parameters);
  }
}

class AddingPersonParams extends Equatable {
  final String name;
  final int noOfBadWords;
  final int amountToPay;
  final String date;
  const AddingPersonParams({
    required this.name,
    required this.noOfBadWords,
    required this.amountToPay,
    required this.date,
  });
  @override
  List<Object?> get props => [name, noOfBadWords, amountToPay, date];
}
