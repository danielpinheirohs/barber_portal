import 'package:barber_portal/core/model/barber.dart';
import 'package:barber_portal/core/model/brb_response.dart';
import 'package:barber_portal/core/repository/barber/barber_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class BarberRepositoryImpl extends BarberRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<BRBResponse> get(String barberId) async {
    try {
      final barberSnapshot = await _firestore.collection('barber').doc(barberId).get();

      if (!barberSnapshot.exists) {
        return BRBResponse.error(
          message: 'A barbearia vinculada ao usuário não foi encontrada, entre em contato com o suporte.',
        );
      }

      final map = barberSnapshot.data()!;
      map.addAll({'id': barberSnapshot.id});

      final barber = Barber.fromMap(map);

      return BRBResponse.success(data: barber);
    } catch (e) {
      Logger().e('Erro interno: $e');
      return BRBResponse.error(
        message: 'Houve um erro interno ao obter a barbearia do usuário.',
      );
    }
  }
}
