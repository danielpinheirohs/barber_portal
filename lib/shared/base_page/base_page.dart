import 'package:barber_portal/app_state.dart';
import 'package:barber_portal/core/cache/barber_cache.dart';
import 'package:barber_portal/core/cache/web_user_cache.dart';
import 'package:barber_portal/core/repository/authentication/authentication_repository_impl.dart';
import 'package:barber_portal/shared/widgets/brb_container.dart';
import 'package:barber_portal/shared/widgets/brb_menu_item.dart';
import 'package:barber_portal/shared/widgets/brb_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BasePage extends StatefulWidget {
  final Widget page;

  const BasePage({super.key, required this.page});

  @override
  createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final _authRepository = AuthenticationRepositoryImpl();

  @override
  void initState() {
    _loadDataFromCache();
    super.initState();
  }

  Future<void> _loadDataFromCache() async {
    context.read<AppState>()
      ..currentWebUser = await WebUserCache().getWebUser()
      ..currentBarber = await BarberCache().getBarber();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authRepository.userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;

          if (user == null) {
            context.go('/login');
          } else {
            return Scaffold(
              body: Row(
                children: [
                  Container(
                    width: 270,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      color: const Color(0xff006B2E),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: Image.asset('images/pinheiro_logo.png'),
                            ),
                            const SizedBox(height: 24),
                            BRBMenuItem(
                              icon: Icons.date_range,
                              text: 'Agenda',
                              onPressed: () => context.go('/schedule'),
                            ),
                            const SizedBox(height: 24),
                            BRBMenuItem(
                              icon: Icons.shopping_cart,
                              text: 'Comandas',
                              onPressed: () => context.go('/command'),
                            ),
                            const SizedBox(height: 24),
                            BRBMenuItem(
                              icon: Icons.room_service,
                              text: 'Serviços',
                              onPressed: () => context.go('/service'),
                            ),
                            const SizedBox(height: 24),
                            BRBMenuItem(
                              icon: Icons.supervised_user_circle,
                              text: 'Profissionais',
                              onPressed: () => context.go('/professional'),
                            ),
                            const SizedBox(height: 24),
                            BRBMenuItem(
                              icon: Icons.people,
                              text: 'Clientes',
                              onPressed: () => context.go('/customer'),
                            ),
                            const SizedBox(height: 24),
                            BRBMenuItem(
                              icon: Icons.auto_graph,
                              text: 'Relatórios',
                              onPressed: () => context.go('/report'),
                            ),
                            const Expanded(child: SizedBox()),
                            const Divider(),
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: () {
                                context.go('/profile');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BRBContainer(
                                    color: Colors.grey[200],
                                    border: Border.all(color: const Color(0xff6F61EF)),
                                    padding: 4,
                                    borderRadius: 10,
                                    child: const Icon(
                                      Icons.person,
                                      size: 40,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  SizedBox(
                                    width: 170,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BRBText.bodyLarge(
                                          text: context.read<AppState>().currentWebUser?.name ?? 'Não informado...',
                                          maxLines: 1,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(height: 4),
                                        BRBText.labelSmall(
                                          text: context.read<AppState>().currentWebUser?.email ?? 'Não informado...',
                                          maxLines: 1,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: widget.page),
                ],
              ),
            );
          }
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
