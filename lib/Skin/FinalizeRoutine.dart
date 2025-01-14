import 'package:flutter/material.dart';
import 'tips.dart';

class FinalizedRoutinePage extends StatelessWidget {
  final String skinType;
  final String skinConcerns;
  final String skinSensitivity;
  final String routineTime;

  const FinalizedRoutinePage({
    Key? key,
    required this.skinType,
    required this.skinConcerns,
    required this.skinSensitivity,
    required this.routineTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 240, 243),
      appBar: AppBar(
        title: const Text(
          'Your Personalized Routine',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 97, 1, 35),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Here are recommended product for your skintype:',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 97, 1, 35),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: Color.fromARGB(255, 97, 1, 35),
                  thickness: 2,
                  indent: 80,
                  endIndent: 80,
                ),
                const SizedBox(height: 20),
            
                _buildRoutineStep('Step 1: Cleanser', 'CeraVe Hydrating Facial Cleanser for $skinType skin', Icons.cleaning_services),
                _buildRoutineStep('Step 2: Toner', 'Thayers Witch Hazel Toner for $skinConcerns', Icons.spa),
                _buildRoutineStep('Step 3: Moisturizer', 'La Roche-Posay Toleriane Ultra for sensitive skin', Icons.local_drink),
                _buildRoutineStep('Step 4: Sunscreen', 'EltaMD UV Clear Broad-Spectrum SPF 46 for $routineTime use', Icons.wb_sunny),
            
                const SizedBox(height: 40),
            
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Your skincare routine has been created!\nWould you like to save or modify it?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 97, 1, 35),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 42,
                            width: MediaQuery.sizeOf(context).width* 0.45,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[700],
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Modify Routine',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                                                        width: MediaQuery.sizeOf(context).width* 0.4,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const TipsArticlesPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color.fromARGB(255, 97, 1, 35),
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 97, 1, 35),
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                textAlign: TextAlign.center,
                                'Save and Explore Tips',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                      SizedBox(height:20,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoutineStep(String stepTitle, String description, IconData icon) {
    return Card(
      elevation: 6,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color.fromARGB(255, 97, 1, 35),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stepTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 97, 1, 35),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
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
