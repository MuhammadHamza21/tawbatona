import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tawbatona/authentication/data/model/user_model.dart';
import 'package:tawbatona/authentication/domain/usecases/create_user_with_email_and_password.dart';
import 'package:tawbatona/authentication/domain/usecases/save_user_data.dart';
import 'package:tawbatona/authentication/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:tawbatona/core/constants/api_constants.dart';
import 'package:tawbatona/core/constants/app_constants.dart';
import 'package:tawbatona/core/error/exceptions.dart';

abstract class BaseAuthenticationRemoteDatasource {
  Future<UserCredential> signInWithEmailAndPassword(SignInParams params);
  User? getCurrentUser();
  Future<void> saveUserData(UserDataParams user);
  Future<UserCredential> createUserWithEmailAndPassword(
      CreateUserParams params);
}

class AuthenticationRemoteDatasource
    extends BaseAuthenticationRemoteDatasource {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<UserCredential> signInWithEmailAndPassword(SignInParams params) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return user;
    } on FirebaseAuthException catch (failure) {
      throw ServerException(message: failure.code);
    }
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword(params) async {
    try {
      var user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      await user.user!.updateDisplayName(params.userName);
      return user;
    } on FirebaseAuthException catch (failure) {
      throw ServerException(message: failure.code);
    }
  }

  @override
  Future<void> saveUserData(user) async {
    final userModel = UserModel(
      userName: user.userName,
      email: user.email,
      userId: user.userId,
    );
    try {
      await _firebaseFirestore
          .collection(ApiConstants.users)
          .doc(user.userId)
          .set(userModel.toJson(userModel));
    } catch (failure) {
      throw ServerException(message: AppConstants.serverErrorMessage);
    }
  }
}
