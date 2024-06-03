import 'package:barber_portal/app_state.dart';
import 'package:barber_portal/core/model/barber_service.dart';
import 'package:barber_portal/core/repository/service/service_repository_impl.dart';
import 'package:barber_portal/core/utils/dialog_utils.dart';
import 'package:barber_portal/features/service/bloc/service_bloc.dart';
import 'package:barber_portal/features/service/view/service_register.dart';
import 'package:barber_portal/shared/widgets/brb_button.dart';
import 'package:barber_portal/shared/widgets/brb_default_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceBloc(ServiceRepositoryImpl()),
      child: const ServiceView(),
    );
  }
}

class ServiceView extends StatefulWidget {
  const ServiceView({super.key});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  late final ServiceBloc bloc;

  List<BarberService>? serviceList;

  @override
  void initState() {
    bloc = context.read<ServiceBloc>();
    bloc.add(PageInitEvent(context.read<AppState>().currentBarber?.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServiceBloc, ServiceState>(
      listener: (context, state) {
        if (state is PageErrorState) {
          DialogUtils.showInformativeErrorDialog(context, state.message);
        }

        if (state is PageLoadedState) {
          setState(() {
            serviceList = state.serviceList;
          });
        }

        if (state is ServiceCreatedState) {
          DialogUtils.showBottomMessage(context, state.message);
        }
      },
      child: BRBDefaultPageLayout(
        pageTitle: 'Serviços',
        rightButton: BRBButton(
          height: 45,
          text: 'Adicionar',
          onPressed: () => DialogUtils.showPopUp(context, ServiceRegister(
            onSavePressed: (name, description, time, price, commission) {
              bloc.add(CreateServiceEvent(
                context.read<AppState>().currentBarber?.id,
                name,
                description,
                time,
                price,
                commission,
              ));
            },
          )),
        ),
        child: Expanded(
          child: ListView.builder(
            itemCount: serviceList?.length ?? 0,
            itemBuilder: (context, index) {
              final currentService = serviceList![index];

              return ListTile(
                title: Text(currentService.name),
                subtitle: Text(NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(currentService.price)),
              );
            },
          ),
        ),
      ),
    );
  }
}
