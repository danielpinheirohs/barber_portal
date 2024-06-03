import 'package:barber_portal/features/login/view/login_page.dart';
import 'package:barber_portal/features/professional/view/professional_page.dart';
import 'package:barber_portal/features/schedule/view/schedule_page.dart';
import 'package:barber_portal/shared/base_page/base_page.dart';
import 'package:go_router/go_router.dart';

final routes = [
  GoRoute(
    path: '/login',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // Transição instantânea
        },
      );
    },
  ),
  GoRoute(
    path: '/schedule',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const BasePage(page: SchedulePage()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // Transição instantânea
        },
      );
    },
  ),
  GoRoute(
    path: '/professional',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const BasePage(page: ProfessionalPage()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // Transição instantânea
        },
      );
    },
  ),
];
