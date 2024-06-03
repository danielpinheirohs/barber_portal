part of 'professional_bloc.dart';

@immutable
sealed class ProfessionalEvent {}

final class PageInitEvent extends ProfessionalEvent {
  final String? barberId;

  PageInitEvent(this.barberId);
}

final class ProfessionalRegisterEvent extends ProfessionalEvent {
  final String? barberId;
  final String name;
  final String phone;
  final String email;

  ProfessionalRegisterEvent(this.barberId, this.name, this.phone, this.email);
}
