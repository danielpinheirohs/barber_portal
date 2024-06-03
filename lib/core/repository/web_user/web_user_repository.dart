import 'package:barber_portal/core/model/brb_response.dart';

abstract class WebUserRepository {
  Future<BRBResponse> get(String userId);
}
