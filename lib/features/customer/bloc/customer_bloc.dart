import 'package:barber_portal/core/model/customer.dart';
import 'package:barber_portal/core/repository/customer/customer_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepositoryImpl _customerRepository;

  CustomerBloc(this._customerRepository) : super(CustomerInitial()) {
    on<PageInitEvent>(_fetchCustomers);
    on<CreateCustomerEvent>(_createCustomer);
  }

  void _fetchCustomers(PageInitEvent event, Emitter emit) async {
    emit(PageLoadingState());

    if (event.barberId == null) {
      emit(PageErrorState('Houve um erro ao obter os clientes. Parece que a barbearia não foi encontrada.'));
    }

    try {
      await emit.onEach(
        _customerRepository.getAllInRealTime(event.barberId!),
        onData: (customerList) {
          emit(PageLoadedState(customerList));
        },
        onError: (error, stackTrace) {
          emit(PageErrorState(error.toString()));
        },
      );
    } catch (e) {
      emit(PageErrorState(e.toString()));
    }
  }

  void _createCustomer(CreateCustomerEvent event, Emitter emit) async {
    emit(PageLoadingState());

    if (event.barberId == null) {
      emit(PageErrorState('Houve um erro, parece que a barbearia não foi encontrada.'));
    }

    final result = await _customerRepository.create(event.barberId!, event.name, event.phone);

    if (result.isError) {
      return emit(PageErrorState(result.message));
    }

    emit(PageLoadedState(result.data));
  }
}
