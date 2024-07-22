import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_place/Canvas/canvas_screen.dart';
import 'package:r_place/Canvas/pixel_service.dart';
import 'package:r_place/firebase_options.dart';
import 'package:r_place/screens/login_screen.dart';
import 'package:r_place/services/auth_service.dart';
import 'package:r_place/services/connection_service.dart';

// Changed to Future to use firebase
Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  // Ensures that the Widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Uses the default options for firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    // Multiprovider to detect changes of the PixelService and the AuthService
    MultiProvider(
      providers: [
        // ChangeNotifier to listen to changes of both services and Provider to
        // check the connection status
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (_) => PixelService()),
        Provider<ConnectionService>(
          create: (_) => ConnectionService(),
        )
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Streambuilder to listen for authentication state changes
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if the user is authenticated the CanvasScreen pops up
            return const CanvasScreen();
          } else {
            // if the user is not authenticated, the LoginScreen pops up
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
