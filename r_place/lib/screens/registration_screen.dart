import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_place/screens/login_screen.dart';
import 'package:r_place/services/auth_service.dart';

// class which represents the RegistrationScreen
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

// state class
class _RegistrationScreenState extends State<RegistrationScreen> {
  // class variables
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmation = TextEditingController();

  // Method to register a new user for the app
  Future<void> _register() async {
    // Instance of AuthService by provide
    final authService = Provider.of<AuthService>(context, listen: false);
    // Try-block to create a new user using the registerWithEmailAndPassword
    // method from AuthService class
    try {
      await authService.registerWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      _navigateToLoginScreen();
      // If an error occurs a Snackbar will be shown which displays the error code
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Registrierung fehlgeschlagen: $e',
          ),
        ),
      );
    }
  }

  Future<void> _navigateToLoginScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // SafeArea to display the statusbar
    return SafeArea(
      child: Scaffold(
        // AppBar displays the title
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 33, 248),
          centerTitle: true,
          title: const Text(
            'Create Account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Padding for better placement
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          // Column Widget with the elements for the RegistrationScreen
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Textfield for the input of the email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              // SizedBox to create some space
              const SizedBox(height: 20.0),
              // Textfield for the input of the password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20.0),
              // Textfiled for password confirmation input
              TextField(
                controller: _passwordConfirmation,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              // ElevatedButton uses _register to register a new user by the
              // inputs
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
