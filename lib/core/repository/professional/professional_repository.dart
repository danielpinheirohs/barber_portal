import 'package:barber_portal/core/model/brb_response.dart';
import 'package:barber_portal/core/model/professional.dart';

abstract class ProfessionalRepository {
  Future<BRBResponse> get(String barberId, String professionalId);
  Future<BRBResponse> getAll(String barberId);
  Stream<List<Professional>> getInRealTime(String barberId);
  Future<BRBResponse> create(String barberId, String name, String phone, String email);
  Future<BRBResponse> delete(String barberId, String professionalId);
}
