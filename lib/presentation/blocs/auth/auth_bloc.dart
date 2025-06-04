import 'package:flutter_bloc/flutter_bloc.dart';

// 👇 IMPORTA LOS CASOS DE USO
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/register_user.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _loginUC;
  final RegisterUser _registerUC;

  AuthBloc({
    required Login loginUC,
    required RegisterUser registerUC,
  })  : _loginUC = loginUC,
        _registerUC = registerUC,
        super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      final name = await _loginUC(event.email, event.password);
      if (name != null) {
        emit(AuthAuthenticated(name));
      } else {
        emit(AuthFailure("Correo o contraseña incorrectos"));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await _registerUC(event.fullName, event.email, event.password);
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Error al registrar"));
      }
    });
  }
}