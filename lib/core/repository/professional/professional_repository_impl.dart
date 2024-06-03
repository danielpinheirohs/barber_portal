import 'package:barber_portal/core/model/brb_response.dart';
import 'package:barber_portal/core/model/professional.dart';
import 'package:barber_portal/core/repository/professional/professional_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfessionalRepositoryImpl extends ProfessionalRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<BRBResponse> create(String barberId, String name, String phone, String email) async {
    try {
      await _firestore.collection('barber').doc(barberId).collection('professional').add({
        'name': name,
        'phone': phone,
        'email': email,
      });

      return BRBResponse(
        statusCode: StatusCode.success,
        message: 'Profissional cadastrado com sucesso!',
      );
    } catch (e) {
      return BRBResponse(
        statusCode: StatusCode.error,
        message: 'Houve um erro interno ao cadastrar o profissional.',
      );
    }
  }

  @override
  Future<BRBResponse> delete(String barberId, String professionalId) async {
    try {
      await _firestore.collection('barber').doc(barberId).collection('professional').doc(professionalId).delete();

      return BRBResponse(
        statusCode: StatusCode.success,
        message: 'Profissional excluído com sucesso!',
      );
    } catch (e) {
      return BRBResponse(
        statusCode: StatusCode.error,
        message: 'Houve um erro interno ao excluir o profissional.',
      );
    }
  }

  @override
  Future<BRBResponse> get(String barberId, String professionalId) async {
    try {
      final professionalSnapshot =
          await _firestore.collection('barber').doc(barberId).collection('professional').doc(professionalId).get();

      if (!professionalSnapshot.exists) {
        return BRBResponse(
          statusCode: StatusCode.error,
          message: 'Profissional não encontrado.',
        );
      }

      final map = professionalSnapshot.data()!;
      map.addAll({'id': professionalSnapshot.id});

      final professional = Professional.fromMap(map);

      return BRBResponse(
        statusCode: StatusCode.success,
        data: professional,
      );
    } catch (e) {
      return BRBResponse(
        statusCode: StatusCode.error,
        message: 'Houve um erro interno ao excluir o profissional.',
      );
    }
  }

  @override
  Future<BRBResponse> getAll(String barberId) async {
    try {
      final professionalSnapshot = await _firestore.collection('barber').doc(barberId).collection('professional').get();

      if (professionalSnapshot.docs.isEmpty) {
        return BRBResponse(
          statusCode: StatusCode.success,
          data: List<Professional>.empty(growable: true),
        );
      }

      final professionalList = professionalSnapshot.docs.map((e) {
        final map = e.data();
        map.addAll({'id': e.id});

        final professional = Professional.fromMap(map);
        return professional;
      }).toList();

      return BRBResponse(
        statusCode: StatusCode.success,
        data: professionalList,
      );
    } catch (e) {
      return BRBResponse(
        statusCode: StatusCode.error,
        message: 'Houve um erro interno ao excluir o profissional.',
      );
    }
  }

  @override
  Stream<List<Professional>> getInRealTime(String barberId) {
    return _firestore.collection('barber').doc(barberId).collection('professional').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Professional.fromSnapshot(doc);
      }).toList();
    });
  }
}
