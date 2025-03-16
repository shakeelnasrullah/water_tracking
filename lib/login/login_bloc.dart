import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:water_tracker/login/login_event.dart';
import 'package:water_tracker/login/login_state.dart';



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool isPasswordVisible = false;

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  void _onLoginButtonPressed(LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    // Simulate a login API call
    await Future.delayed(const Duration(seconds: 2));

    if (event.email == "test@example.com" && event.password == "password123") {
      emit(LoginSuccess());
    } else {
      emit(const LoginFailure(error: "Invalid email or password"));
    }
  }

  void _onTogglePasswordVisibility(TogglePasswordVisibility event, Emitter<LoginState> emit) {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityToggled(isVisible: isPasswordVisible));
  }
}