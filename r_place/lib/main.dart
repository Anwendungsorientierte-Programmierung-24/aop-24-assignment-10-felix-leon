import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:r_place/firebase_options.dart';

// Changed to Future to use firebase
Future<void> main() async {
  // Ensures that the Widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Uses the default options for firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Placeholder(),
    );
  }
}
