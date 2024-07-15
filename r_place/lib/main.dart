import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_place/Canvas/canvas_screen.dart';
import 'package:r_place/Canvas/pixel_service.dart';
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
  runApp(MultiProvider(
    providers: [
      Provider<AuthService>(
        create: (context) => AuthService(),
      ),
      Provider<PixelService>(create: (context) => PixelService())
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Use a StreamBuilder to listen for authentication state changes
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Check if the user is authenticated
          if (snapshot.hasData) {
            // If authenticated, show the CanvasScreen
            return const CanvasScreen();
          } else {
            // If not authenticated, show the LoginScreen
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
