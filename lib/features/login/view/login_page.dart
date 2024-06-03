import 'package:barber_portal/app_state.dart';
import 'package:barber_portal/core/cache/barber_cache.dart';
import 'package:barber_portal/core/cache/web_user_cache.dart';
import 'package:barber_portal/core/repository/authentication/authentication_repository_impl.dart';
import 'package:barber_portal/core/repository/barber/barber_repository_impl.dart';
import 'package:barber_portal/core/repository/web_user/web_user_repository_impl.dart';
import 'package:barber_portal/core/utils/dialog_utils.dart';
import 'package:barber_portal/features/login/bloc/login_bloc.dart';
import 'package:barber_portal/shared/widgets/brb_button.dart';
import 'package:barber_portal/shared/widgets/brb_container.dart';
import 'package:barber_portal/shared/widgets/brb_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        AuthenticationRepositoryImpl(),
        WebUserRepositoryImpl(),
        BarberRepositoryImpl(),
      ),
      child: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          DialogUtils.showInformativeErrorDialog(context, state.message);
        }

        if (state is LoginSuccessState) {
          context.read<AppState>()
            ..currentWebUser = state.userData
            ..currentBarber = state.barber;

          WebUserCache().saveWebUser(state.userData);
          BarberCache().saveBarber(state.barber);

          context.go('/schedule');
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.centerRight,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                  ),
                ),
                BRBContainer(
                  elevation: true,
                  width: 500,
                  height: 400,
                  borderRadius: 10,
                  margin: 24,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BRBTextFormField(
                        controller: _emailController,
                        label: 'Email',
                      ),
                      const SizedBox(height: 24),
                      BRBTextFormField(
                        controller: _passwordController,
                        label: 'Senha',
                      ),
                      const SizedBox(height: 36),
                      BRBButton.large(
                          text: 'Entrar',
                          isLoading: state is LoadingState,
                          onPressed: () {
                            bloc.add(LoginButtonPressedEvent(
                              _emailController.text,
                              _passwordController.text,
                            ));
                          }),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
