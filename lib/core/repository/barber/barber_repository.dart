import 'package:barber_portal/core/model/brb_response.dart';

abstract class BarberRepository {
  Future<BRBResponse> get(String barberId);
}
