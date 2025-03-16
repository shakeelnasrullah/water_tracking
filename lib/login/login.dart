import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker/login/login_bloc.dart';
import 'package:water_tracker/login/login_event.dart';
import 'package:water_tracker/login/login_state.dart';
import 'package:water_tracker/signup/signup.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  void _goToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Successful')),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 80),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Securely Login to account",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail),
                          labelText: "Email Address",
                          labelStyle: TextStyle(color: Colors.grey[850]),
                          floatingLabelStyle: const TextStyle(color: Colors.deepPurpleAccent),
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      // Password Field
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: _passwordController,
                            obscureText: !(state is PasswordVisibilityToggled ? state.isVisible : false),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  (state is PasswordVisibilityToggled && state.isVisible)
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  context.read<LoginBloc>().add(TogglePasswordVisibility());
                                },
                              ),
                              labelText: "Password",
                              floatingLabelStyle: const TextStyle(color: Colors.deepPurpleAccent),
                              errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              labelStyle: TextStyle(color: Colors.grey[850]),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return SizedBox(width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                              LoginButtonPressed(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5DCCFC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        child: const Text(
                          "LOG IN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4.0,
                            color: Colors.white,
                            fontFamily: "Inter",
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 25),
                TextButton(
                  onPressed: () {
                    print('Forgot Password pressed');
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF5DCCFC),
                      fontSize: 16,
                      color: const Color(0xFF5DCCFC),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "-OR Continue with-",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _googleButton("Google", "assets/images/google.png"),
                    _googleButton("Facebook", "assets/images/facebook.png"),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Create An Account",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: () => _goToSignUp(context),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF5DCCFC),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text("By clicking Login, you agree with our", style: TextStyle(color: Colors.black, fontSize: 13),),
                const SizedBox(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text("Terms & Condition ", style: TextStyle(color: const Color(0xFF5DCCFC), fontSize: 13),),
                  Text("and "),
                  Text("Privacy Policy", style: TextStyle(color: const Color(0xFF5DCCFC), fontSize: 13),),
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _googleButton(String name , String image){
  return  Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8), // Add spacing between buttons
      child: ElevatedButton(
        onPressed: () {
          print(' Button Pressed');
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12), // Add padding
          backgroundColor: Colors.white, // Button background color
          foregroundColor: Colors.blue, // Text and icon color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // Rounded corners
            side: BorderSide(
              color: const Color(0xFF5DCCFC), // Border color
              width: 2, // Border width
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center content horizontally
          children: [
            Image.asset(
              image, // Path to your image asset
              width: 24, // Adjust image width
              height: 24, // Adjust image height
            ),
            SizedBox(width: 8), // Add spacing between image and text
            Text(name, style: TextStyle(fontSize: 16, fontFamily: "Inter")),
          ],
        ),
      ),
    ),
  );
}