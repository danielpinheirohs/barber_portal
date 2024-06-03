import 'package:barber_portal/core/model/barber_service.dart';
import 'package:barber_portal/core/model/brb_response.dart';

abstract class ServiceRepository {
  Stream<List<BarberService>> getInRealTime(String barberId);
  Future<BRBResponse> create(
    String barberId,
    String name,
    String description,
    int time,
    double price,
    double commission,
  );
}
