// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tawbatona/authentication/domain/repository/base_auth_repository.dart';
import 'package:tawbatona/core/error/failures.dart';
import 'package:tawbatona/core/usecase/base_usecase.dart';

class SignInWithEmailAndPasswordUsecase
    extends BaseUsecase<UserCredential, SignInParams> {
  final BaseAuthenticationRepository baseAuthenticationRepository;

  SignInWithEmailAndPasswordUsecase(
      {required this.baseAuthenticationRepository});
  @override
  Future<Either<Failure, UserCredential>> call(SignInParams parameters) async {
    return await baseAuthenticationRepository
        .signInWithEmailAndPassword(parameters);
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;
  const SignInParams({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [email, password];
}
