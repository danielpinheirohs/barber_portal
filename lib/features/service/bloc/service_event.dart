part of 'service_bloc.dart';

@immutable
sealed class ServiceEvent {}

final class PageInitEvent extends ServiceEvent {
  final String? barberId;

  PageInitEvent(this.barberId);
}

final class CreateServiceEvent extends ServiceEvent {
  final String? barberId;
  final String name;
  final String description;
  final int time;
  final double price;
  final double commission;

  CreateServiceEvent(this.barberId, this.name, this.description, this.time, this.price, this.commission);
}
