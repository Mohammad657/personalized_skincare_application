import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController(text: 'John Doe');
  final TextEditingController emailController = TextEditingController(text: 'johndoe@gmail.com');
  final TextEditingController phoneController = TextEditingController(text: '+1 (234) 567-890');
  final TextEditingController ageController = TextEditingController(text: '29 years');
  final TextEditingController skinTypeController = TextEditingController(text: 'Oily');
  final TextEditingController routineTimeController = TextEditingController(text: 'Morning & Night');

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
            // Profile Overview Section (Center aligned)
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
                    Text(
                      isEditing ? 'Edit Your Profile' : 'Profile Overview',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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

            // Profile Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    _buildProfileDetail(
                      icon: Icons.email,
                      title: 'Email',
                      controller: emailController,
                      isEditing: isEditing,
                    ),
                    const SizedBox(height: 20),
                    _buildProfileDetail(
                      icon: Icons.phone,
                      title: 'Phone',
                      controller: phoneController,
                      isEditing: isEditing,
                    ),
                    const SizedBox(height: 20),
                    _buildProfileDetail(
                      icon: Icons.calendar_today,
                      title: 'Age',
                      controller: ageController,
                      isEditing: isEditing,
                    ),
                    const SizedBox(height: 20),
                    _buildProfileDetail(
                      icon: Icons.water_drop,
                      title: 'Skin Type',
                      controller: skinTypeController,
                      isEditing: isEditing,
                    ),
                    const SizedBox(height: 20),
                    _buildProfileDetail(
                      icon: Icons.timer,
                      title: 'Routine Time',
                      controller: routineTimeController,
                      isEditing: isEditing,
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
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing; // Toggle edit mode
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: const Color.fromARGB(255, 97, 1, 35),
                      ),
                      child: Text(
                        isEditing ? 'Save Changes' : 'Edit Profile',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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
          ],
        ),
      ),
    );
  }
}
