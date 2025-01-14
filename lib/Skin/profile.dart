import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personalized_skincare_application/Skin/widget/routine_time_dialog.dart';
import 'package:personalized_skincare_application/Skin/widget/skin_concerns_dialog.dart';
import 'package:personalized_skincare_application/Skin/widget/skin_type_dialog.dart';
import 'package:personalized_skincare_application/project_managment.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditingName = false;
  bool isEditingEmail = false;
  bool isEditingPhone = false;
  bool isEditingAge = false;
  bool isEditingSkinType = false;
  bool isEditingRoutingType = false;
  bool isEditingSkinConcerns = false;

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController skinTypeController = TextEditingController();
  final TextEditingController routineTimeController = TextEditingController();
  final TextEditingController skinConcernsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // جلب البيانات من Firestore عند تحميل الصفحة
  }

  Future<void> _fetchUserData() async {
    final projectManagement = ProjectManagement();
    try {
      // جلب البيانات من Firestore
      Map<String, dynamic> userData =
          await projectManagement.fetchUserDataFromFirestore();

      // ملء الحقول بالبيانات
      setState(() {
        nameController.text = userData['username'] ?? 'John Doe';
        emailController.text = userData['email'] ?? 'johndoe@gmail.com';
        phoneController.text = userData['phone'] ?? '+1 (234) 567-890';
        ageController.text = userData['age'] ?? '29 years';
        skinTypeController.text = userData['skin_type'] ?? 'Oily';
        routineTimeController.text =
            userData['routinetime'] ?? 'Morning & Night';
        skinConcernsController.text = userData['skin_concerns'] ?? 'Acne';
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _updateUserDataInFirestore() async {
    try {
      final projectManagement = ProjectManagement();

      // تجميع البيانات المعدلة في خريطة
      Map<String, dynamic> updatedData = {
        'username': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'age': ageController.text,
        'skin_type': skinTypeController.text,
        'routinetime': routineTimeController.text,
        'skin_concerns': skinConcernsController.text,
      };

      // إرسال البيانات إلى Firestore
      await projectManagement.updateUserData(updatedData);
      print('Data updated successfully!');
    } catch (e) {
      print("Error updating user data: $e");
    }
  }
 Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // الانتقال إلى صفحة تسجيل الدخول بعد تسجيل الخروج
      Navigator.of(context).pushReplacementNamed('/signin'); // تأكد من إضافة صفحة تسجيل الدخول
    } catch (e) {
      print('Error signing out: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 238, 243),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 97, 1, 35),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        toolbarHeight: 60, // Adjusting AppBar height
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 97, 1, 35),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      'Your Skincare Journey Began on 14th January 2025',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 200, 210),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    _buildProfileDetail(
                      icon: Icons.person,
                      title: 'UserName',
                      controller: nameController,
                      isEditing: isEditingName,
                      onTap: () {
                        setState(() {
                          isEditingName = !isEditingName;
                          _updateUserDataInFirestore();
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildProfileDetail(
                      icon: Icons.email,
                      title: 'Email',
                      controller: emailController,
                      isEditing: isEditingEmail,
                      onTap: () {
                        setState(() {
                          isEditingEmail = !isEditingEmail;
                          _updateUserDataInFirestore();
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildProfileDetail(
                      icon: Icons.phone,
                      title: 'Phone',
                      controller: phoneController,
                      isEditing: isEditingPhone,
                      onTap: () {
                        setState(() {
                          isEditingPhone = !isEditingPhone;
                          _updateUserDataInFirestore();
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildProfileDetail(
                      icon: Icons.calendar_today,
                      title: 'Age',
                      controller: ageController,
                      isEditing: isEditingAge,
                      onTap: () {
                        setState(() {
                          isEditingAge = !isEditingAge;
                          _updateUserDataInFirestore();
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildProfileDetail(
                      icon: Icons.water_drop,
                      title: 'Skin Type',
                      controller: skinTypeController,
                      isEditing: isEditingSkinType,
                      onTap: () {
                        if (!isEditingSkinType) {
                          setState(() {
                            isEditingSkinType = true;
                          });
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SkinTypeDialog(
                                initialValue: skinTypeController.text,
                                onSaved: (selectedTime) {
                                  skinTypeController.text = selectedTime;
                                  _updateUserDataInFirestore();
                                },
                                onSaveComplete: () {
                                  setState(() {
                                    isEditingSkinType = false;
                                  });
                                },
                              );
                            },
                          );
                        } else {
                          // Optionally handle the case when already editing
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildProfileDetail(
                      icon: Icons.timer,
                      title: 'Routine Time',
                      controller: routineTimeController,
                      isEditing: isEditingRoutingType,
                      onTap: () {
                        if (!isEditingRoutingType) {
                          setState(() {
                            isEditingRoutingType = true;
                          });
                          showDialog(
                            context: context,
                            builder: (context) {
                              return RoutineTimeDialog(
                                initialValue: routineTimeController.text,
                                onSaved: (selectedTime) {
                                  routineTimeController.text = selectedTime;
                                  _updateUserDataInFirestore();
                                },
                                onSaveComplete: () {
                                  setState(() {
                                    isEditingRoutingType = false;
                                  });
                                },
                              );
                            },
                          );
                        } else {
                          // Optionally handle the case when already editing
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildProfileDetail(
                      icon: Icons.water_drop,
                      title: 'Skin Concerns',
                      controller: skinConcernsController,
                      isEditing: isEditingSkinConcerns,
                      onTap: () {
                        if (!isEditingSkinConcerns) {
                          setState(() {
                            isEditingSkinConcerns = true;
                          });
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SkinConcernsDialog(
                                initialValue: skinConcernsController.text,
                                onSaved: (selectedTime) {
                                  skinConcernsController.text = selectedTime;
                                  _updateUserDataInFirestore();
                                },
                                onSaveComplete: () {
                                  setState(() {
                                    isEditingSkinConcerns = false;
                                  });
                                },
                              );
                            },
                          );
                        } else {
                          // Optionally handle the case when already editing
                        }
                      },
                    ),
                  const SizedBox(height: 20),
                    // Favorite Doctor Section
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 97, 1, 35),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(Icons.favorite, color: Colors.white),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Favorite Doctor',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 65, 1, 23),
                                    ),
                                  ),
                                  Text(
                                    'Dr. Jane',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 97, 1, 35),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                     const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _signOut,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: const Color.fromARGB(255, 97, 1, 35),
                      ),
                      child: Text("Sign Out", style: TextStyle(color: Colors.white, fontSize: 20),),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail({
    required IconData icon,
    required String title,
    required TextEditingController controller,
    required bool isEditing,
    required GestureTapCallback? onTap,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 97, 1, 35),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 65, 1, 23),
                    ),
                  ),
                  isEditing
                      ? TextFormField(
                          controller: controller,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 97, 1, 35),
                          ),
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                        )
                      : Text(
                          controller.text,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 97, 1, 35),
                          ),
                        ),
                ],
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 97, 1, 35),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(isEditing ? Icons.check : Icons.edit,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
