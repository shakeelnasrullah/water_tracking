import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker/signup/signup_event.dart';
import 'package:water_tracker/signup/signup_state.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
  }

  Future<void> _onSignUpButtonPressed(
      SignUpButtonPressed event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading());

    // Simulate a network call or validation
    await Future.delayed(const Duration(seconds: 2));

    // Validate inputs
    if (event.name.isEmpty ||
        event.email.isEmpty ||
        event.phoneNumber.isEmpty ||
        event.password.isEmpty) {
      emit(SignUpFailure(error: 'All fields are required'));
    } else if (event.password.length < 8) {
      emit(SignUpFailure(error: 'Password must be at least 8 characters long'));
    } else {
      // Simulate a successful sign-up
      emit(SignUpSuccess());
    }
  }
}