// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({
    required this.message,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
  @override
  List<Object?> get props => [super.message];
}

class OfflineFailure extends Failure {
  const OfflineFailure({required super.message});
  @override
  List<Object?> get props => [super.message];
}

class LocalFailure extends Failure {
  const LocalFailure({required super.message});
  @override
  List<Object?> get props => [super.message];
}
