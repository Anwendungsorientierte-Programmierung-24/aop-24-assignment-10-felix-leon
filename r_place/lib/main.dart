import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_place/firebase_options.dart';
import 'package:r_place/screens/login_screen.dart';
import 'package:r_place/services/auth_service.dart';

// Changed to Future to use firebase
Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  // Ensures that the Widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Uses the default options for firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Provider(
    create: (context) => AuthService(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromARGB(255, 5, 33, 248),
          selectionColor: Color.fromARGB(255, 5, 33, 248),
          selectionHandleColor: Color.fromARGB(255, 5, 33, 248),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
