part of 'customer_bloc.dart';

@immutable
sealed class CustomerState {}

final class CustomerInitial extends CustomerState {}

final class PageLoadingState extends CustomerState {}

final class PageErrorState extends CustomerState {
  final String message;

  PageErrorState(this.message);
}

final class PageLoadedState extends CustomerState {
  final List<Customer> customerList;

  PageLoadedState(this.customerList);
}

final class ServiceCreatedState extends CustomerState {
  final String message;

  ServiceCreatedState(this.message);
}
