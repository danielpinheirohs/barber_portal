import 'package:barber_portal/core/model/brb_response.dart';

abstract class AuthenticationRepository {
  Future<BRBResponse> login(String email, String password);
  Future<void> logout();
}
