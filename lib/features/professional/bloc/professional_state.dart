part of 'professional_bloc.dart';

@immutable
sealed class ProfessionalState {}

final class ProfessionalInitial extends ProfessionalState {}

final class PageLoadingState extends ProfessionalState {}

final class PageErrorState extends ProfessionalState {
  final String message;

  PageErrorState(this.message);
}

final class ProfessionalFetchSuccess extends ProfessionalState {
  final List<Professional> professionalList;

  ProfessionalFetchSuccess(this.professionalList);
}

final class ProfessionalLoaded extends ProfessionalState {
  final List<Professional> professionalList;

  ProfessionalLoaded(this.professionalList);
}

final class ProfessionalRegisterSuccessState extends ProfessionalState {
  final String message;

  ProfessionalRegisterSuccessState(this.message);
}
