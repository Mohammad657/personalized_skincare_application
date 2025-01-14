import 'package:flutter/material.dart';
import 'package:personalized_skincare_application/project_managment.dart';
import 'routine.dart';
import 'skinquiz.dart';

class ReviewPage extends StatefulWidget {
  final String skinType;
  final String skinConcerns;
  final String skinSensitivity;
  final String routineTime;

  const ReviewPage({
    Key? key,
    required this.skinType,
    required this.skinConcerns,
    required this.skinSensitivity,
    required this.routineTime,
  }) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _currentIndex = 0;
  ProjectManagement projectManagement = ProjectManagement();

  final List<Widget> _pages = [
    SkinQuizPage(),
    // Replace with your Tips page widget
    Center(child: Text('Tips Page')),
    // Replace with your Profile page widget
    Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEEAF0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          title: const Text(
            'Review Your Answers',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'DancingScript',
              fontSize: 24,
            ),
          ),
          backgroundColor: const Color(0xFF610123),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    'Here is a review of your selections. Please ensure everything looks correct:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF610123),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // Skin Type Card
                _buildAnswerStep(
                  title: 'Skin Type',
                  description: widget.skinType,
                  color: const Color(0xFF781432),
                  icon: Icons.water_drop,
                ),
                const SizedBox(height: 10),

                // Skin Concerns Card
                _buildAnswerStep(
                  title: 'Skin Concerns',
                  description: widget.skinConcerns,
                  color: const Color(0xFF781432),
                  icon: Icons.warning_amber_outlined,
                ),
                const SizedBox(height: 10),

                // Skin Sensitivity Card
                _buildAnswerStep(
                  title: 'Skin Sensitivity',
                  description: widget.skinSensitivity,
                  color: const Color(0xFF781432),
                  icon: Icons.spa,
                ),
                const SizedBox(height: 10),

                // Routine Time Card
                _buildAnswerStep(
                  title: 'Routine Time',
                  description: widget.routineTime,
                  color: const Color(0xFF781432),
                  icon: Icons.access_time,
                ),
                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    'Thank you for reviewing your answers!\nBased on your input, we can now create a personalized skincare routine for you.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF781432),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),

                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF781432),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Would you like to continue and create your routine?',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SkinQuizPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF781432),
                                side: const BorderSide(
                                  color: Color(0xFF781432),
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // padding: const EdgeInsets.symmetric(
                                //   horizontal: 20,
                                //   vertical: 15,
                                // ),
                              ),
                              child: const Text(
                                'Go Back to Your Quiz',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            height: 80,
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            child: ElevatedButton(
                              onPressed: () async {
                                String skinType = widget.skinType;
                                String skinConcerns = widget.skinConcerns;
                                String skinSensitivity = widget.skinSensitivity;
                                String routineTime = widget.routineTime;

                                // تأكد من أنك تمرر context للوظيفة
                                await projectManagement.addProject(
                                  context, // أولًا يتم تمرير الـ context
                                  skinType,
                                  skinConcerns,
                                  skinSensitivity,
                                  routineTime,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF610123),
                                side: const BorderSide(
                                  color: Color(0xFF610123),
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // padding: const EdgeInsets.symmetric(
                                //   horizontal: 20,
                                //   vertical: 15,
                                // ),
                              ),
                              child: const Text(
                                'Continue to Your Routine',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _pages[index]),
          );
        },
        backgroundColor: const Color.fromARGB(255, 97, 1, 35),
        selectedItemColor: const Color.fromARGB(255, 246, 246, 182),
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_rounded),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tips_and_updates),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Helper method to build a step for each answer
  Widget _buildAnswerStep({
    required String title,
    required String description,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
