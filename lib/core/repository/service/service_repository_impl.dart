import 'package:barber_portal/core/model/barber_service.dart';
import 'package:barber_portal/core/model/brb_response.dart';
import 'package:barber_portal/core/repository/service/service_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceRepositoryImpl extends ServiceRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<BarberService>> getInRealTime(String barberId) {
    return _firestore.collection('barber').doc(barberId).collection('service').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return BarberService.fromSnapshot(doc);
      }).toList();
    });
  }

  @override
  Future<BRBResponse> create(
    String barberId,
    String name,
    String description,
    int time,
    double price,
    double commission,
  ) async {
    try {
      _firestore.collection('barber').doc(barberId).collection('service').add({
        'name': name,
        'description': description,
        'time': time,
        'price': price,
        'commission': commission,
      });

      return BRBResponse.success(message: 'Serviço cadastrado com sucesso.');
    } catch (e) {
      return BRBResponse.error(message: 'Houve um erro interno ao cadastrar o serviço.');
    }
  }
}
