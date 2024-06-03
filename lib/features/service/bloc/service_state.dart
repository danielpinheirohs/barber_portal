part of 'service_bloc.dart';

@immutable
sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}

final class PageLoadingState extends ServiceState {}

final class PageErrorState extends ServiceState {
  final String message;

  PageErrorState(this.message);
}

final class PageLoadedState extends ServiceState {
  final List<BarberService> serviceList;

  PageLoadedState(this.serviceList);
}

final class ServiceCreatedState extends ServiceState {
  final String message;

  ServiceCreatedState(this.message);
}
