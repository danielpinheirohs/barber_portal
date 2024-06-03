import 'package:barber_portal/core/model/barber_service.dart';
import 'package:barber_portal/core/repository/service/service_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepositoryImpl _serviceRepository;

  ServiceBloc(this._serviceRepository) : super(ServiceInitial()) {
    on<PageInitEvent>(_fetchServices);
    on<CreateServiceEvent>(_createService);
  }

  void _fetchServices(PageInitEvent event, Emitter emit) async {
    emit(PageLoadingState());

    if (event.barberId == null) {
      emit(PageErrorState('Houve um erro ao obter os serviços. Parece que a barbearia não foi encontrada.'));
    }

    try {
      await emit.onEach(
        _serviceRepository.getInRealTime(event.barberId!),
        onData: (professionalList) {
          emit(PageLoadedState(professionalList));
        },
        onError: (error, stackTrace) {
          emit(PageErrorState(error.toString()));
        },
      );
    } catch (e) {
      emit(PageErrorState(e.toString()));
    }
  }

  void _createService(CreateServiceEvent event, Emitter emit) async {
    emit(PageLoadingState());

    if (event.barberId == null) {
      emit(PageErrorState('Houve um erro ao obter os serviços. Parece que a barbearia não foi encontrada.'));
    }

    final result = await _serviceRepository.create(
      event.barberId!,
      event.name,
      event.description,
      event.time,
      event.price,
      event.commission,
    );

    if (result.isError) {
      return emit(PageErrorState(result.message));
    }

    emit(ServiceCreatedState(result.message));
  }
}
