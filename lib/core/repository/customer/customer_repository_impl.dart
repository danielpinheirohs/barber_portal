import 'package:barber_portal/core/model/brb_response.dart';
import 'package:barber_portal/core/model/customer.dart';
import 'package:barber_portal/core/repository/customer/customer_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<BRBResponse> create(String barberId, String name, String phone) async {
    try {
      await _firestore.collection('barber').doc(barberId).collection('customer').add({
        'name': name,
        'phone': phone,
      });

      return BRBResponse.success(message: 'Cliente cadastrado com sucesso.');
    } catch (e) {
      return BRBResponse.error(message: 'Houve um erro interno ao cadastrar o cliente.');
    }
  }

  @override
  Stream<List<Customer>> getAllInRealTime(String barberId) {
    return _firestore.collection('barber').doc(barberId).collection('customer').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Customer.fromSnapshot(doc);
      }).toList();
    });
  }
}
