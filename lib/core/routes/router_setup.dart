import 'package:barber_portal/core/routes/routes.dart';
import 'package:go_router/go_router.dart';

class RouterSetup {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: routes,
  );
}
