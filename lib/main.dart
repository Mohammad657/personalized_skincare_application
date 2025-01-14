import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalized_skincare_application/Skin/routine.dart';
import 'package:personalized_skincare_application/Starting/sign_up.dart';
import 'package:personalized_skincare_application/Starting/welcome.dart';
import 'firebase_options.dart';
import 'Starting/sign_in.dart';
import 'Starting/about_us.dart';
import 'Skin/skinquiz.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
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
        '/': (context) => const WelcomePage(),
        '/signup': (context) => const SignUpPage(),
        '/signin': (context) => const SignInPage(),
        '/aboutus': (context) => const AboutUsPage(),
        '/skinquiz': (context) => const SkinQuizPage(),
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _loadingIndicator(); 
        }

        if (snapshot.hasData) {
          return _handleUserAuthenticated();
        } else {
          return const Welcome();
        }
      },
    );
  }

  Widget _loadingIndicator() {
    return Scaffold(
      body: Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _handleUserAuthenticated() {
    return FutureBuilder<bool>(
      future: _checkUserDataExistence(),
      builder: (context, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return _loadingIndicator();
        }

        if (dataSnapshot.hasData && dataSnapshot.data!) {
          return _buildRoutinePage(context); 
        } else {
          return const WelcomePage(); 
        }
      },
    );
  }

  Future<bool> _checkUserDataExistence() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false; 
    }

    String userId = user.uid; 

    try {
     
      DocumentSnapshot projectDoc = await FirebaseFirestore.instance
          .collection('projects')
          .doc(userId)
          .get();
      return projectDoc.exists; 
    } catch (e) {
      print("Error checking project data: $e");
      return false; 
    }
  }

  Widget _buildRoutinePage(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _fetchUserDataFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _loadingIndicator(); 
        }

        if (snapshot.hasData) {
          final data = snapshot.data!;
          return RoutinePage(
            skinType: data['skin_type']!,
            skinConcerns: data['skin_concerns']!,
            skinSensitivity: data['skin_sensitivity']!,
            routineTime: data['routinetime']!,
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: const Text('No data found.'),
            ),
          );
        }
      },
    );
  }

  Future<Map<String, String>> _fetchUserDataFromFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      try {
        DocumentSnapshot projectDoc = await FirebaseFirestore.instance
            .collection('projects')
            .doc(userId)
            .get();

        if (projectDoc.exists) {
          var data = projectDoc.data() as Map<String, dynamic>;
          return {
            'skin_type': data['skin_type'] ?? '',
            'skin_concerns': data['skin_concerns'] ?? '',
            'skin_sensitivity': data['skin_sensitivity'] ?? '',
            'routinetime': data['routinetime'] ?? '',
          };
        } else {
          throw Exception("Project data not found");
        }
      } catch (e) {
        print("Error fetching project data: $e");
        throw e;
      }
    } else {
      throw Exception("User is not authenticated");
    }
  }
}