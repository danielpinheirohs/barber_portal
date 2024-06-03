import 'package:barber_portal/core/model/brb_response.dart';
import 'package:barber_portal/core/model/customer.dart';

abstract class CustomerRepository {
  Stream<List<Customer>> getAllInRealTime(String barberId);
  Future<BRBResponse> create(String barberId, String name, String phone);
}
