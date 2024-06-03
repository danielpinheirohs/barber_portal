import 'package:barber_portal/app_state.dart';
import 'package:barber_portal/core/model/customer.dart';
import 'package:barber_portal/core/repository/customer/customer_repository_impl.dart';
import 'package:barber_portal/core/utils/dialog_utils.dart';
import 'package:barber_portal/features/customer/bloc/customer_bloc.dart';
import 'package:barber_portal/features/customer/view/customer_register.dart';
import 'package:barber_portal/shared/widgets/brb_button.dart';
import 'package:barber_portal/shared/widgets/brb_default_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerBloc(CustomerRepositoryImpl()),
      child: const CustomerView(),
    );
  }
}

class CustomerView extends StatefulWidget {
  const CustomerView({super.key});

  @override
  State<CustomerView> createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  late final CustomerBloc bloc;

  List<Customer>? customerList;

  @override
  void initState() {
    bloc = context.read<CustomerBloc>();
    bloc.add(PageInitEvent(context.read<AppState>().currentBarber?.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if (state is PageErrorState) {
          DialogUtils.showInformativeErrorDialog(context, state.message);
        }

        if (state is PageLoadedState) {
          setState(() {
            customerList = state.customerList;
          });
        }

        if (state is ServiceCreatedState) {
          DialogUtils.showBottomMessage(context, state.message);
        }
      },
      child: BRBDefaultPageLayout(
        pageTitle: 'Clientes',
        rightButton: BRBButton(
          height: 45,
          text: 'Adicionar',
          onPressed: () => DialogUtils.showPopUp(context, CustomerRegister(
            onSavePressed: (name, phone) {
              bloc.add(CreateCustomerEvent(
                context.read<AppState>().currentBarber?.id,
                name,
                phone,
              ));
            },
          )),
        ),
        child: Expanded(
          child: ListView.builder(
            itemCount: customerList?.length ?? 0,
            itemBuilder: (context, index) {
              final currentCustomer = customerList![index];

              return ListTile(
                title: Text(currentCustomer.name),
                subtitle: Text(currentCustomer.phone),
              );
            },
          ),
        ),
      ),
    );
  }
}
