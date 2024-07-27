import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tawbatona/core/error/failures.dart';

abstract class BaseUsecase<T, Parameters> {
  Future<Either<Failure, T>> call(Parameters parameters);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
