import 'package:flutter/material.dart';
import 'package:personalized_skincare_application/Skin/profile.dart';
import 'package:personalized_skincare_application/Skin/review.dart';
import 'tips.dart';


class SkinQuizPage extends StatefulWidget {
  const SkinQuizPage({super.key});

  @override
  _SkinQuizPageState createState() => _SkinQuizPageState();
}

class _SkinQuizPageState extends State<SkinQuizPage> {
  String? skinType;
  List<String> selectedConcerns = [];
  String? routineTime;
  String? skinSensitivity;

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SkinQuizPage(),
    TipsArticlesPage(),  
    ProfilePage(),  // Updated to point to ProfilePage
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 240, 243),
      appBar: AppBar(
        title: const Text(
          'Skin Quiz',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 97, 1, 35),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tell us about your skin!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 65, 1, 23),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Answer a few questions to help us create your personalized skincare routine.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 65, 1, 23),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  '1. What is your skin type?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 65, 1, 23),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        activeColor: Colors.pink,
                        title: const Text('Oily'),
                        value: 'Oily',
                        groupValue: skinType,
                        onChanged: (value) {
                          setState(() {
                            skinType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: Colors.pink,
                        title: const Text('Dry'),
                        value: 'Dry',
                        groupValue: skinType,
                        onChanged: (value) {
                          setState(() {
                            skinType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: Colors.pink,
                        title: const Text('Combination'),
                        value: 'Combination',
                        groupValue: skinType,
                        onChanged: (value) {
                          setState(() {
                            skinType = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  '2. Select your main skin concerns:',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 65, 1, 23),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        activeColor: Colors.pink,
                        title: const Text('Acne'),
                        value: selectedConcerns.contains('Acne'),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedConcerns.add('Acne');
                            } else {
                              selectedConcerns.remove('Acne');
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Colors.pink,
                        title: const Text('Wrinkles'),
                        value: selectedConcerns.contains('Wrinkles'),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedConcerns.add('Wrinkles');
                            } else {
                              selectedConcerns.remove('Wrinkles');
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Colors.pink,
                        title: const Text('Dark Spots'),
                        value: selectedConcerns.contains('Dark Spots'),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedConcerns.add('Dark Spots');
                            } else {
                              selectedConcerns.remove('Dark Spots');
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  '3. Do you have sensitive skin?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 65, 1, 23),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        activeColor: Colors.pink,
                        title: const Text('Yes'),
                        value: 'Yes',
                        groupValue: skinSensitivity,
                        onChanged: (value) {
                          setState(() {
                            skinSensitivity = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: Colors.pink,
                        title: const Text('No'),
                        value: 'No',
                        groupValue: skinSensitivity,
                        onChanged: (value) {
                          setState(() {
                            skinSensitivity = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  '4. When do you follow your skincare routine?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 65, 1, 23),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        activeColor: Colors.pink,
                        title: const Text('Morning'),
                        value: 'Morning',
                        groupValue: routineTime,
                        onChanged: (value) {
                          setState(() {
                            routineTime = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        activeColor: Colors.pink,
                        title: const Text('Night'),
                        value: 'Night',
                        groupValue: routineTime,
                        onChanged: (value) {
                          setState(() {
                            routineTime = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: skinType != null && routineTime != null && selectedConcerns.isNotEmpty && skinSensitivity != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewPage(
                                skinType: skinType!,
                                skinConcerns: selectedConcerns.join(', '),
                                skinSensitivity: skinSensitivity!,
                                routineTime: routineTime!,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color.fromARGB(255, 97, 1, 35),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Submit'),
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
}

