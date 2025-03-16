import 'package:flutter/material.dart';
import 'package:water_tracker/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  Color blueColor = const Color(0xFF5DCCFC);
  Color blueLightColor = const Color(0xFFF4FCFF);

  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _emailController =
      TextEditingController(); // Controller for email field
  final _passwordController =
      TextEditingController(); // Controller for password field
  bool _isPasswordVisible = false; // Track password visibility

  // Toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _goToSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) =>  SignUpScreen()));
  }

  // Validate email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Regex for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Validate password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
    }
  }

  void _googleSignIn() {}

  void _facebookSignIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.white),
      height: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                "Login",
                style: TextStyle(
                    fontFamily: "Inter",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Securely Login to account",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey, // Assign the form key
                child: Column(
                  children: [
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      // Controller for email field
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.mail),
                        labelText: "Email Address",
                        labelStyle: TextStyle(color: Colors.grey[850]),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.deepPurpleAccent),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: _validateEmail, // Add email validation
                    ),
                    SizedBox(height: 20), // Add some spacing

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_isPasswordVisible,
                      // Toggle password visibility
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed:
                              _togglePasswordVisibility, // Toggle visibility on icon press
                        ),
                        labelText: "Password",
                        floatingLabelStyle:
                            const TextStyle(color: Colors.deepPurpleAccent),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        labelStyle: TextStyle(color: Colors.grey[850]),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: _validatePassword, // Add password validation
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: _rememberMe,
                    activeColor: Colors.blue,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Remember Me',
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.blue,
                      //foregroundColor: blueColor,
                      backgroundColor: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      )),
                  child: const Text(
                    "LOG IN",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                        color: Colors.white,
                        fontFamily: "Inter",
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                onPressed: () {
                  // Add your onPressed logic here
                  print('Underlined TextButton pressed!');
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: blueColor,
                    fontSize: 16,
                    color: blueColor, // Customize text color
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "-OR Continue with-",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    // Add spacing between buttons
                    child: ElevatedButton(
                      onPressed: _googleSignIn,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        // Add padding
                        backgroundColor: blueLightColor,
                        // Button background color
                        foregroundColor: blueColor,
                        side: BorderSide(color: blueColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Center content horizontally
                        children: [
                          Image.asset('assets/images/google.png',
                              // Path to your image asset
                              width: 30,
                              height: 30,
                              fit: BoxFit.fill),
                          const SizedBox(width: 10),
                          // Add spacing between image and text
                          const Text(
                            'Google',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Second Button
                  Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    // Add spacing between buttons
                    child: ElevatedButton(
                      onPressed: _facebookSignIn,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        // Add padding
                        backgroundColor: blueLightColor,
                        // Button background color
                        foregroundColor: blueColor,
                        side: BorderSide(color: blueColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // Center content horizontally
                        children: [
                          Image.asset('assets/images/facebook.png',
                              // Path to your image asset
                              width: 30, // Adjust image width
                              height: 30,
                              fit: BoxFit.fill),
                          const SizedBox(width: 10),
                          // Add spacing between image and text
                          const Text(
                            'Facebook',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Create An Account",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Poppins"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: _goToSignUp,
                    child: Text("Sign Up",
                    style: TextStyle(
                        fontSize: 14,
                        color: blueColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "By clicking Login, you agree to our",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Poppins"),
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Terms & Conditions",
                    style: TextStyle(
                        fontSize: 12,
                        color: blueColor,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Poppins"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "and",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Poppins"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                        fontSize: 12,
                        color: blueColor,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Poppins"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
