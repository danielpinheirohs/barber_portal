import 'package:barber_portal/core/model/brb_response.dart';
import 'package:barber_portal/core/model/web_user.dart';
import 'package:barber_portal/core/repository/web_user/web_user_repository.dart';
import 'package:barber_portal/core/utils/logger_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WebUserRepositoryImpl extends WebUserRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<BRBResponse> get(String userId) async {
    try {
      final webUserSnapshot = await _firestore.collection('web_user').doc(userId).get();

      if (!webUserSnapshot.exists) {
        return BRBResponse(
          statusCode: StatusCode.error,
          message: 'Não foi encontrado dados de um usuário vinculado a essas credenciais.',
        );
      }

      final map = webUserSnapshot.data()!;
      map.addAll({'id': webUserSnapshot.id});

      final webUser = WebUser.fromMap(map);

      return BRBResponse(
        statusCode: StatusCode.success,
        data: webUser,
      );
    } catch (e) {
      LoggerUtils.internalError(e);
      return BRBResponse(
        statusCode: StatusCode.error,
        message: 'Houve um erro interno ao obter os dados do usuário.',
      );
    }
  }
}
