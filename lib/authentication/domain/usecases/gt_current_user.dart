// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tawbatona/authentication/domain/repository/base_auth_repository.dart';

class GetCurrentUserUsecase {
  final BaseAuthenticationRepository baseAuthenticationRepository;
  GetCurrentUserUsecase({
    required this.baseAuthenticationRepository,
  });

  User? call() {
    return baseAuthenticationRepository.getCurrentUser();
  }
}
