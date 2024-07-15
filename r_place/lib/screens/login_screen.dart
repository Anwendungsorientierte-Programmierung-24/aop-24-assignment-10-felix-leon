import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:r_place/Canvas/canvas_screen.dart';
import 'package:r_place/screens/registration_screen.dart';
import 'package:r_place/services/auth_service.dart';

// class represents the login screen
class LoginScreen extends StatefulWidget {
  // constants
  static const _appTitle = 'R/Place App';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// state class
class _LoginScreenState extends State<LoginScreen> {
  // class variables
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Method to login with user credentials using the signIn method from
  // AuthService class
  Future<void> _login() async {
    // Instance of authService by using the Provider
    final authService = Provider.of<AuthService>(context, listen: false);
    // Try-block which uses the signIn method of the AuthService class and the
    // texts from the TextEditinControllers as input
    // If login was successful the user will be directed to the CanvasScreen by
    // using zhe _navigateToCanvasScreen method
    try {
      await authService.signIn(_emailController.text, _passwordController.text);
      _navigateToCanvasScreen();
      // Navigation zum Canvas hinzufügen
    } catch (e) {
      // If sign in doesnt work a Snackbar will be displayed showing the
      // specific error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
        ),
      ));
    }
  }

  // Method to navigate to the RegistrationScreen
  Future<void> _navigateToRegistrationScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistrationScreen(),
      ),
    );
  }

  // Method to navigate to the CanvasScreen
  Future<void> _navigateToCanvasScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CanvasScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // SafeArea to display the statusbar
    return SafeArea(
      child: Scaffold(
        // AppBar displays the title of the app
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 33, 248),
          centerTitle: true,
          title: const Text(
            LoginScreen._appTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // SingelChildScrollView to disable renderflex overflow problems
        body: SingleChildScrollView(
          // Center to center the column with the features in it
          child: Center(
            child: Column(
              children: [
                // Padding for better placement of the image
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
                    child: Image.asset('assets/login_screen.jpg'),
                  ),
                ),
                // SizedBox with the TextField for the emailinput
                SizedBox(
                  // Mediaquery for better placement
                  width: MediaQuery.of(context).size.width / 2,
                  // Textfield uses _emailController to use that input
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    // styled by Inputdecoration
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        fillColor: Color.fromARGB(255, 5, 33, 248),
                        focusColor: Color.fromARGB(255, 5, 33, 248),
                        hoverColor: Color.fromARGB(255, 5, 33, 248),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 5, 33, 248)))),
                    cursorColor: const Color.fromARGB(255, 5, 33, 248),
                    cursorErrorColor: const Color.fromARGB(255, 5, 33, 248),
                  ),
                ),
                // SizedBox to create space between both TextFields
                const SizedBox(
                  height: 30.0,
                ),
                // SizedBox with the TextField for the passwordinput
                SizedBox(
                  // Mediaquery for better placement
                  width: MediaQuery.of(context).size.width / 2,
                  // Textfield uses _emailController to use that input
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    // styled by Inputdecoration
                    decoration: const InputDecoration(
                        hintText: 'Passwort',
                        fillColor: Color.fromARGB(255, 5, 33, 248),
                        focusColor: Color.fromARGB(255, 5, 33, 248),
                        hoverColor: Color.fromARGB(255, 5, 33, 248),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 5, 33, 248)))),
                    cursorColor: const Color.fromARGB(255, 5, 33, 248),
                    cursorErrorColor: const Color.fromARGB(255, 5, 33, 248),
                  ),
                ),
                // SizedBox to create some space
                const SizedBox(
                  height: 30.0,
                ),
                // ElevatedButton uses _login method to login in the app with
                // the given input
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: const Text('Login'),
                ),
                // SizedBox to create some space
                const SizedBox(
                  width: 30.0,
                ),
                // TextButton to navigate to the registerscreen
                TextButton(
                  // _navigateToRegistrationSceen method to  navigate to the
                  // RegistrationScreen
                  onPressed: () {
                    _navigateToRegistrationScreen();
                  },
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
