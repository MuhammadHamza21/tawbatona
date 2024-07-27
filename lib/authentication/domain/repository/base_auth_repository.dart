import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tawbatona/authentication/domain/usecases/create_user_with_email_and_password.dart';
import 'package:tawbatona/authentication/domain/usecases/save_user_data.dart';
import 'package:tawbatona/authentication/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:tawbatona/core/error/failures.dart';

abstract class BaseAuthenticationRepository {
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
      SignInParams parameters);
  Future<Either<Failure, UserCredential>> createUserWithEmailAndPassword(
      CreateUserParams params);
  Future<Either<Failure, void>> saveUserData(UserDataParams user);
  User? getCurrentUser();
}
