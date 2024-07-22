import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_place/Canvas/canvas_screen.dart';
import 'package:r_place/screens/registration_screen.dart';
import 'package:r_place/services/auth_service.dart';
import 'package:r_place/services/connection_service.dart';

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
  bool _isConnected = false;
  bool _isSnackbarVisible = false;

  // Override of initState method to check the connection status by using the
  // ConnectionService
  @override
  void initState() {
    super.initState();
    // Set the connection status to the current
    final connectionService =
        Provider.of<ConnectionService>(context, listen: false);
    connectionService.status.listen((isConnected) {
      // if the connection is lost a snackbar with an error will be shown
      if (_isConnected != isConnected) {
        setState(() {
          _isConnected = isConnected;
        });
        _showConnectionStatusSnackbar(isConnected);
      }
    });
  }

  // Method to display a snackbar with a custom message
  void _showConnectionStatusSnackbar(bool isConnected) {
    if (!_isSnackbarVisible) {
      final message = isConnected
          ? 'Internet connection restored.'
          : 'No internet connection. Cannot log in.';
      final backgroundColor = isConnected ? Colors.green : Colors.red;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );

      setState(() {
        _isSnackbarVisible = true;
      });

      // Reset snackbar visibility flag after the snackbar duration
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isSnackbarVisible = false;
          });
        }
      });
    }
  }

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
        backgroundColor: Colors.red,
        content: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
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
          automaticallyImplyLeading: false,
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
                const SizedBox(
                  height: 30.0,
                ),
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
                const SizedBox(
                  height: 50.0,
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
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(Icons.email),
                      ),
                      hintText: 'Email',
                      fillColor: Color.fromARGB(255, 5, 33, 248),
                      focusColor: Color.fromARGB(255, 5, 33, 248),
                      hoverColor: Color.fromARGB(255, 5, 33, 248),
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
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Icon(Icons.lock),
                        ),
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
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      backgroundColor: const Color.fromARGB(255, 5, 33, 248),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      minimumSize: const Size(220.0, 40.0)),
                  onPressed: () {
                    _login();
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // SizedBox to create some space
                const SizedBox(
                  width: 50.0,
                ),
                // Padding Widget for better placement
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  // Row widget with a information text and gesture detection to
                  // navigate to the RegistrationScreen
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      // GestureDetector to navigate to the registerscreen
                      GestureDetector(
                        onTap: _navigateToRegistrationScreen,
                        child: const Text(
                          'Create one here!',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
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
