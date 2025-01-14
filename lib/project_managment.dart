import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personalized_skincare_application/Skin/routine.dart';

class ProjectManagement {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // دالة للتحقق من وجود المشروع في Firestore
  Future<bool> isProjectExist() async {
    try {
      // الحصول على UID المستخدم الحالي من Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("No user is logged in.");
        return false;
      }

      String userId = user.uid; // استخدام الـ UID كمفتاح للمستند

      // التحقق من وجود بيانات للمستخدم في Firestore
      DocumentSnapshot projectDoc = await _firestore.collection('projects').doc(userId).get();

      if (projectDoc.exists) {
        print("Project data already exists for the user.");
        return true; // إذا كانت البيانات موجودة
      } else {
        print("No project data found for the user.");
        return false; // إذا لم تكن البيانات موجودة
      }
    } catch (e) {
      print("Error checking project existence: $e");
      return false;
    }
  }

  // دالة لإضافة المشروع إذا لم يكن موجود مسبقًا
  Future<void> addProject(
     BuildContext context, 
  String skinType,
  String skinConcerns,
  String skinSensitivity,
  String routineTime,
  ) async {
    try {
      // الحصول على UID المستخدم الحالي من Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("No user is logged in.");
        return;
      }

      String userId = user.uid; // استخدام الـ UID كمفتاح للمستند

      // تحقق من وجود المشروع للمستخدم
      bool projectExists = await isProjectExist();
      if (projectExists) {
        // إذا كانت البيانات موجودة مسبقًا، انتقل إلى RoutinePage مباشرة
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
        return; // لا تضف المشروع مجددًا إذا كان موجودًا
      }

      // تحضير البيانات لإضافتها إلى Firestore
      Map<String, dynamic> projectData = {
        'skin_type': skinType,
        'skin_concerns': skinConcerns,
        'skin_sensitivity': skinSensitivity,
        'routinetime': routineTime,
      };

      // إضافة البيانات إلى Firestore مع استخدام UID كمفتاح للمستند
      await _firestore.collection('projects').doc(userId).set(projectData);

      print("Project added successfully!");

      // بعد إضافة المشروع بنجاح، انتقل إلى RoutinePage
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
        // جلب بيانات المشروع من Firestore
        DocumentSnapshot projectDoc = await FirebaseFirestore.instance
            .collection('projects')
            .doc(userId)
            .get();

        // جلب بيانات المستخدم من Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (projectDoc.exists && userDoc.exists) {
          var projectData = projectDoc.data() as Map<String, dynamic>;
          var userData = userDoc.data() as Map<String, dynamic>;

          // دمج البيانات من كلا المجموعتين
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
      // Accessing Firestore and updating the document
      final userRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid);
      await userRef.update(updatedData);
    } catch (e) {
      print("Error updating user data: $e");
    }
  }


}
