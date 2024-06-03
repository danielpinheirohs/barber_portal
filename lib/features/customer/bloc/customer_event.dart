part of 'customer_bloc.dart';

@immutable
sealed class CustomerEvent {}

final class PageInitEvent extends CustomerEvent {
  final String? barberId;

  PageInitEvent(this.barberId);
}

final class CreateCustomerEvent extends CustomerEvent {
  final String? barberId;
  final String name;
  final String phone;

  CreateCustomerEvent(this.barberId, this.name, this.phone);
}
