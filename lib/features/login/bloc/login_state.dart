part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final WebUser userData;
  final Barber barber;

  LoginSuccessState(this.userData, this.barber);
}

final class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState(this.message);
}
