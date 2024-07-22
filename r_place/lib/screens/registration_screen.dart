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
    // Check if passwords match
    if (_passwordController.text != _passwordConfirmation.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match.'),
        ),
      );
      return;
    }
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
          backgroundColor: Colors.red,
          content: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
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
          automaticallyImplyLeading: true,
          leading: IconButton(
              onPressed: () {
                _navigateToLoginScreen();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
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
        // SingleChildScrollView to disable renderflex overflow problems
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                // Padding for better placement
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3.0,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8.0)),
                    // Image is displayed
                    child: Image.asset('assets/welcome_screen.jpg'),
                  ),
                ),
                // SizedBox to create some space
                const SizedBox(
                  height: 60.0,
                ),
                // Textfield for the input of the email
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(Icons.email),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 5, 33, 248),
                        ),
                      ),
                    ),
                    cursorColor: const Color.fromARGB(255, 5, 33, 248),
                    cursorErrorColor: const Color.fromARGB(255, 5, 33, 248),
                  ),
                ),
                // SizedBox to create some space
                const SizedBox(height: 20.0),
                // Textfield for the input of the password
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(Icons.lock),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 5, 33, 248),
                        ),
                      ),
                    ),
                    cursorColor: const Color.fromARGB(255, 5, 33, 248),
                    cursorErrorColor: const Color.fromARGB(255, 5, 33, 248),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Textfiled for password confirmation input
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    controller: _passwordConfirmation,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(Icons.lock),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 5, 33, 248),
                        ),
                      ),
                    ),
                    cursorColor: const Color.fromARGB(255, 5, 33, 248),
                    cursorErrorColor: const Color.fromARGB(255, 5, 33, 248),
                  ),
                ),
                // ElevatedButton uses _register to register a new user by the
                // inputs
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      backgroundColor: const Color.fromARGB(255, 5, 33, 248),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      minimumSize: const Size(220.0, 40.0)),
                  onPressed: _register,
                  child: const Text(
                    'Create account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
