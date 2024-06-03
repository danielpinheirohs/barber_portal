import 'package:barber_portal/core/model/professional.dart';
import 'package:barber_portal/core/repository/professional/professional_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'professional_event.dart';
part 'professional_state.dart';

class ProfessionalBloc extends Bloc<ProfessionalEvent, ProfessionalState> {
  final ProfessionalRepositoryImpl _professionalRepository;

  ProfessionalBloc(this._professionalRepository) : super(ProfessionalInitial()) {
    on<PageInitEvent>(_fetchProfessionals);
    on<ProfessionalRegisterEvent>(_registerProfessional);
  }

  void _fetchProfessionals(PageInitEvent event, Emitter emit) async {
    emit(PageLoadingState());

    if (event.barberId == null) {
      emit(PageErrorState('Houve um erro ao obter os profissionais. Parece que a barbearia não foi encontrada.'));
    }

    try {
      await emit.onEach(
        _professionalRepository.getInRealTime(event.barberId!),
        onData: (professionalList) {
          emit(ProfessionalLoaded(professionalList));
        },
        onError: (error, stackTrace) {
          emit(PageErrorState(error.toString()));
        },
      );
    } catch (e) {
      emit(PageErrorState(e.toString()));
    }
  }

  void _registerProfessional(ProfessionalRegisterEvent event, Emitter emit) async {
    emit(PageLoadingState());

    if (event.barberId == null) {
      emit(PageErrorState('Houve uma falha ao oter a barbearia para o registro do profissional.'));
    }

    final registerResult = await _professionalRepository.create(
      event.barberId!,
      event.name,
      event.phone,
      event.email,
    );

    if (registerResult.isError) {
      return emit(PageErrorState(registerResult.message));
    }

    emit(ProfessionalRegisterSuccessState(registerResult.message));
  }
}
