import 'package:flutter/material.dart';
import 'package:personalized_skincare_application/Starting/welcome.dart' as welcome;
import 'package:personalized_skincare_application/Starting/sign_up.dart' as signup;
import 'package:personalized_skincare_application/Starting/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Starting/about_us.dart';
import 'Skin/skinquiz.dart'; // Make sure to import the SkinQuizPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Personalized Skincare App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity, 
      ),
      routes: {
        '/': (context) => const welcome.WelcomePage(), // Default initial route
        '/signup': (context) => const signup.SignUpPage(),
        '/signin': (context) => const SignInPage(),
        '/aboutus': (context) => const AboutUsPage(), // Use a separate route for AboutUsPage
        '/skinquiz': (context) => const SkinQuizPage(),
      },
    );
  }
}
