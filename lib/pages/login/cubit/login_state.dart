part of 'login_cubit.dart';
 class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String errorMessage;
  LoginFailure({required this.errorMessage});
}

