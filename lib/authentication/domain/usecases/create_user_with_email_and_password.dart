// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tawbatona/authentication/domain/repository/base_auth_repository.dart';
import 'package:tawbatona/core/error/failures.dart';
import 'package:tawbatona/core/usecase/base_usecase.dart';

class CreateUserWithEmailAndPasswordUsecase
    extends BaseUsecase<UserCredential, CreateUserParams> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  CreateUserWithEmailAndPasswordUsecase(
      {required this.baseAuthenticationRepository});
  @override
  Future<Either<Failure, UserCredential>> call(
      CreateUserParams parameters) async {
    return await baseAuthenticationRepository
        .createUserWithEmailAndPassword(parameters);
  }
}

class CreateUserParams extends Equatable {
  final String userName;
  final String email;
  final String password;
  const CreateUserParams({
    required this.userName,
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [userName, email, password];
}
