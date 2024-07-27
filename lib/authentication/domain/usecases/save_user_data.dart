// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tawbatona/authentication/domain/repository/base_auth_repository.dart';
import 'package:tawbatona/core/error/failures.dart';
import 'package:tawbatona/core/usecase/base_usecase.dart';

class SaveUserDataUsecase extends BaseUsecase<void, UserDataParams> {
  final BaseAuthenticationRepository baseAuthenticationRepository;
  SaveUserDataUsecase({
    required this.baseAuthenticationRepository,
  });
  @override
  Future<Either<Failure, void>> call(UserDataParams parameters) async {
    return await baseAuthenticationRepository.saveUserData(parameters);
  }
}

class UserDataParams extends Equatable {
  final String userId;
  final String userName;
  final String email;
  const UserDataParams({
    required this.userId,
    required this.userName,
    required this.email,
  });

  @override
  List<Object?> get props => [userId, userName, email];
}
