import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userName;
  final String email;
  final String userId;
  const UserModel({
    required this.userName,
    required this.email,
    required this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userName: json['userName'],
        email: json['email'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson(UserModel userModel) => {
        'userName': userModel.userName,
        'email': userModel.email,
        'userId': userModel.userId,
      };

  @override
  List<Object?> get props => [userName, email, userId];
}
