import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personalized_skincare_application/Skin/routine.dart';

class ProjectManagement {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> isProjectExist() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("No user is logged in.");
        return false;
      }

      String userId = user.uid;

      DocumentSnapshot projectDoc = await _firestore.collection('projects').doc(userId).get();

      if (projectDoc.exists) {
        print("Project data already exists for the user.");
        return true; 
      } else {
        print("No project data found for the user.");
        return false; 
      }
    } catch (e) {
      print("Error checking project existence: $e");
      return false;
    }
  }

  Future<void> addProject(
     BuildContext context, 
  String skinType,
  String skinConcerns,
  String skinSensitivity,
  String routineTime,
  ) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("No user is logged in.");
        return;
      }

      String userId = user.uid; 

      bool projectExists = await isProjectExist();
      if (projectExists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RoutinePage(
              skinType: skinType,
              skinConcerns: skinConcerns,
              skinSensitivity: skinSensitivity,
              routineTime: routineTime,
            ),
          ),
        );
        return; 
      }

      Map<String, dynamic> projectData = {
        'skin_type': skinType,
        'skin_concerns': skinConcerns,
        'skin_sensitivity': skinSensitivity,
        'routinetime': routineTime,
      };

      await _firestore.collection('projects').doc(userId).set(projectData);

      print("Project added successfully!");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RoutinePage(
            skinType: skinType,
            skinConcerns: skinConcerns,
            skinSensitivity: skinSensitivity,
            routineTime: routineTime,
          ),
        ),
      );
    } catch (e) {
      print("Error adding project: $e");
    }
  }



   Future<Map<String, dynamic>> fetchUserDataFromFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      try {
        DocumentSnapshot projectDoc = await FirebaseFirestore.instance
            .collection('projects')
            .doc(userId)
            .get();

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (projectDoc.exists && userDoc.exists) {
          var projectData = projectDoc.data() as Map<String, dynamic>;
          var userData = userDoc.data() as Map<String, dynamic>;

          return {
            'skin_type': projectData['skin_type'] ?? '',
            'skin_concerns': projectData['skin_concerns'] ?? '',
            'skin_sensitivity': projectData['skin_sensitivity'] ?? '',
            'routinetime': projectData['routinetime'] ?? '',
            'age': userData['age'] ?? '',
            'email': userData['email'] ?? '',
            'phone': userData['phone'] ?? '',
            'username': userData['username'] ?? '',
          };
        } else {
          throw Exception("Project or User data not found");
        }
      } catch (e) {
        print("Error fetching data: $e");
        throw e;
      }
    } else {
      throw Exception("User is not authenticated");
    }
  }


  Future<void> updateUserData(Map<String, dynamic> updatedData) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid);
      await userRef.update(updatedData);
    } catch (e) {
      print("Error updating user data: $e");
    }
  }


}
