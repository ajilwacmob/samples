import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AppDataState extends Equatable {
  List<UserData>? users;

  String? emailError;
  String? userNameError;

  AppDataState({
    this.users,
    this.emailError,
    this.userNameError,
  });

  AppDataState copyWith({
    List<UserData>? users,
    String? emailError,
    String? userNameError,
  }) {
    return AppDataState(
      users: users ?? this.users,
      emailError: emailError ?? this.emailError,
      userNameError: userNameError ?? this.userNameError,
    );
  }

  @override
  List<Object?> get props => [users, emailError, userNameError];
}

class UserData extends Equatable {
  final String? name;
  final String? email;

  const UserData({this.name, this.email});

  UserData copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    return UserData(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [name, email];
}
