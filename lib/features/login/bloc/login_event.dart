part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressedEvent(this.email, this.password);
}
