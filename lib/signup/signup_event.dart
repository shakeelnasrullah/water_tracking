import 'package:equatable/equatable.dart';


abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;

  const SignUpButtonPressed({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, phoneNumber, password];
}
