import 'package:barber_portal/core/model/brb_response.dart';
import 'package:barber_portal/core/repository/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final _fireseAuth = FirebaseAuth.instance;

  Stream<User?> get userStream => _fireseAuth.authStateChanges();
  User? get currentUser => _fireseAuth.currentUser;

  @override
  Future<BRBResponse> login(String email, String password) async {
    try {
      final loginResult = await _fireseAuth.signInWithEmailAndPassword(email: email, password: password);

      return BRBResponse(statusCode: StatusCode.success, data: loginResult.user);
    } catch (e) {
      Logger().e('Error: $e');
      return BRBResponse(statusCode: StatusCode.error, message: 'Houve um erro interno ao fazer login.');
    }
  }

  @override
  Future<void> logout() async {
    return await _fireseAuth.signOut();
  }
}
