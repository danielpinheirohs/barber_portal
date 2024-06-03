import 'package:barber_portal/core/model/barber.dart';
import 'package:barber_portal/core/model/web_user.dart';
import 'package:barber_portal/core/repository/authentication/authentication_repository_impl.dart';
import 'package:barber_portal/core/repository/barber/barber_repository_impl.dart';
import 'package:barber_portal/core/repository/web_user/web_user_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepositoryImpl _authenticationRepository;
  final WebUserRepositoryImpl _webUserRepository;
  final BarberRepositoryImpl _barberRepository;

  LoginBloc(this._authenticationRepository, this._webUserRepository, this._barberRepository) : super(LoginInitial()) {
    on<LoginButtonPressedEvent>(_login);
  }

  void _login(LoginButtonPressedEvent event, Emitter emit) async {
    emit(LoadingState());

    final loginResult = await _authenticationRepository.login(event.email, event.password);

    if (loginResult.isError) {
      return emit(LoginErrorState(loginResult.message));
    }

    final userDataResult = await _webUserRepository.get((loginResult.data as User).uid);

    if (userDataResult.isError) {
      _authenticationRepository.logout();
      return emit(LoginErrorState(userDataResult.message));
    }

    final barberResult = await _barberRepository.get((userDataResult.data as WebUser).barberId);

    if (barberResult.isError) {
      _authenticationRepository.logout();
      return emit(LoginErrorState(barberResult.message));
    }

    emit(LoginSuccessState(userDataResult.data, barberResult.data));
  }
}
