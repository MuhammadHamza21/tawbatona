part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class SignInWithEmailAndPasswordLoadingState
    extends AuthenticationState {}

final class SignInWithEmailAndPasswordOfflineState
    extends AuthenticationState {}

final class SignInWithEmailAndPasswordSuccessState
    extends AuthenticationState {}

final class SignInWithEmailAndPasswordErrorState extends AuthenticationState {}

final class CreateUserWithEmailAndPasswordLoadingState
    extends AuthenticationState {}

final class CreateUserWithEmailAndPasswordOfflineState
    extends AuthenticationState {}

final class CreateUserWithEmailAndPasswordSuccessState
    extends AuthenticationState {}

final class CreateUserWithEmailAndPasswordErrorState
    extends AuthenticationState {}

final class SaveUserDataSuccessState extends AuthenticationState {}

final class SaveUserDataErrorState extends AuthenticationState {}

final class SaveUserDataLoadingState extends AuthenticationState {}

final class SaveUserDataOfflineState extends AuthenticationState {}
