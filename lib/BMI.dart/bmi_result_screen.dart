import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {
  final double bmi;
  final String gender; // Add gender to show the same image

  BmiResultScreen({required this.bmi, required this.gender});

  // This method determines the BMI category based on the BMI value
  String getBmiCategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi >= 18.5 && bmi <= 24.9) return "Normal";
    if (bmi >= 25 && bmi <= 29.9) return "Overweight";
    return "Obese";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your BMI result'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the same gender-based image in the center
            Image.asset(
              'assets/${gender.toLowerCase()}.png',
              height: 400,
            ),
            SizedBox(height: 20),

            // Display the BMI value
            Text(
              'Your BMI is ${bmi.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),

            // Display the BMI category
            Text(
              'You are ${getBmiCategory(bmi)}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
