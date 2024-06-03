import 'package:barber_portal/app_state.dart';
import 'package:barber_portal/core/model/professional.dart';
import 'package:barber_portal/core/repository/professional/professional_repository_impl.dart';
import 'package:barber_portal/core/utils/dialog_utils.dart';
import 'package:barber_portal/features/professional/bloc/professional_bloc.dart';
import 'package:barber_portal/features/professional/view/professional_register.dart';
import 'package:barber_portal/shared/widgets/brb_button.dart';
import 'package:barber_portal/shared/widgets/brb_default_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfessionalPage extends StatelessWidget {
  const ProfessionalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfessionalBloc(ProfessionalRepositoryImpl()),
      child: const ProfessionalView(),
    );
  }
}

class ProfessionalView extends StatefulWidget {
  const ProfessionalView({super.key});

  @override
  State<ProfessionalView> createState() => _ProfessionalViewState();
}

class _ProfessionalViewState extends State<ProfessionalView> {
  late final ProfessionalBloc bloc;

  List<Professional>? currentProfessionalList;

  @override
  void initState() {
    bloc = context.read<ProfessionalBloc>();
    bloc.add(PageInitEvent(context.read<AppState>().currentBarber?.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfessionalBloc, ProfessionalState>(
      listener: (context, state) {
        if (state is PageErrorState) {
          DialogUtils.showInformativeErrorDialog(context, state.message);
        }

        if (state is ProfessionalLoaded) {
          setState(() {
            currentProfessionalList = state.professionalList;
          });
        }
      },
      child: BRBDefaultPageLayout(
        pageTitle: 'Profissionais',
        rightButton: BRBButton(
          height: 45,
          text: 'Adicionar',
          onPressed: () => DialogUtils.showPopUp(context, ProfessionalRegister(
            onSavePressed: (name, phone, email) {
              bloc.add(ProfessionalRegisterEvent(
                context.read<AppState>().currentBarber?.id,
                name,
                phone,
                email,
              ));
            },
          )),
        ),
        child: Expanded(
          child: ListView.builder(
            itemCount: currentProfessionalList?.length ?? 0,
            itemBuilder: (context, index) {
              final currentProfessional = currentProfessionalList![index];

              return ListTile(
                title: Text(currentProfessional.name),
                subtitle: Text(currentProfessional.email),
              );
            },
          ),
        ),
      ),
    );
  }
}
