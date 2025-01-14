import 'package:flutter/material.dart';
import 'FinalizeRoutine.dart';

class RoutinePage extends StatelessWidget {
  final String skinType;
  final String skinConcerns;
  final String skinSensitivity;
  final String routineTime;

  const RoutinePage({
    Key? key,
    required this.skinType,
    required this.skinConcerns,
    required this.skinSensitivity,
    required this.routineTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Skincare Routine Steps',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 97, 1, 35),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Based on your answers, here is your skincare routine steps that you could follow!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 97, 1, 35),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

               
                _buildRoutineStep('Step 1: Cleanser', _getCleanserRecommendation(), Icons.cleaning_services),
                const SizedBox(height: 15),
                _buildRoutineStep('Step 2: Toner', _getTonerRecommendation(), Icons.opacity),
                const SizedBox(height: 15),
                _buildRoutineStep('Step 3: Moisturizer', _getMoisturizerRecommendation(), Icons.spa),
                const SizedBox(height: 15),
                _buildRoutineStep('Step 4: Sunscreen', _getSunscreenRecommendation(), Icons.wb_sunny),
                const SizedBox(height: 30),

               
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalizedRoutinePage(
                          skinType: skinType,
                          skinConcerns: skinConcerns,
                          skinSensitivity: skinSensitivity,
                          routineTime: routineTime,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 97, 1, 35),
                    foregroundColor: const Color.fromARGB(255, 253, 240, 243),
                    side: const BorderSide(
                      color: const Color.fromARGB(255, 253, 240, 243),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'Finalize My Routine',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoutineStep(String title, String description, IconData icon) {
    return Card(
      elevation: 8,
      color: const Color.fromARGB(255, 253, 240, 243),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 97, 1, 35).withOpacity(0.1),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                color: const Color.fromARGB(255, 97, 1, 35),
                size: 30,
              ),
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

  String _getCleanserRecommendation() {
    if (skinType == "Oily") {
      return "Use a gentle foaming cleanser for oily skin.";
    } else if (skinType == "Dry") {
      return "Use a hydrating cream cleanser.";
    } else {
      return "Use a balanced gel cleanser.";
    }
  }

  String _getTonerRecommendation() {
    if (skinConcerns.contains("Acne")) {
      return "Try a salicylic acid toner to combat acne.";
    } else if (skinConcerns.contains("Wrinkles")) {
      return "A hydrating toner with anti-aging properties.";
    } else {
      return "A refreshing toner for normal skin.";
    }
  }

  String _getMoisturizerRecommendation() {
    if (skinSensitivity == "Sensitive") {
      return "Use a fragrance-free, soothing moisturizer.";
    } else {
      return "Choose a light, oil-free moisturizer.";
    }
  }

  String _getSunscreenRecommendation() {
    if (routineTime == "Morning") {
      return "Always apply SPF 30 or higher sunscreen.";
    } else {
      return "Sunscreen is not necessary for nighttime routines.";
    }
  }
}
