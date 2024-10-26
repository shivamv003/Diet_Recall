// import 'package:flutter/material.dart';

// class BMIPage extends StatefulWidget {
//   const BMIPage({super.key});

//   @override
//   _BMIPageState createState() => _BMIPageState();
// }

// class _BMIPageState extends State<BMIPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _heightController = TextEditingController();
//   final _weightController = TextEditingController();
//   double? _bmi;
//   String _bmiCategory = '';

//   // Method to calculate BMI
//   void _calculateBMI() {
//     if (_formKey.currentState?.validate() ?? false) {
//       // Parse the height and weight from input
//       final heightInMeters = double.tryParse(_heightController.text);
//       final weightInKilograms = double.tryParse(_weightController.text);

//       // Ensure height and weight are valid numbers and not null
//       if (heightInMeters != null &&
//           weightInKilograms != null &&
//           heightInMeters > 0) {
//         setState(() {
//           // Correct BMI formula: weight in kg / (height in meters)^2
//           _bmi = weightInKilograms / (heightInMeters * heightInMeters);

//           // Get the BMI category based on the calculated BMI
//           _bmiCategory = _getBMICategory(_bmi!);
//         });
//       } else {
//         // Show a message if inputs are invalid
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please enter valid height and weight.')),
//         );
//       }
//     }
//   }

//   // Method to get the BMI category based on the calculated BMI
//   String _getBMICategory(double bmi) {
//     if (bmi < 18.5) {
//       return 'Underweight';
//     } else if (bmi >= 18.5 && bmi < 24.9) {
//       return 'Normal weight';
//     } else if (bmi >= 25 && bmi < 29.9) {
//       return 'Overweight';
//     } else {
//       return 'Obese';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('BMI Index'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: <Widget>[
//                   TextFormField(
//                     controller: _heightController,
//                     decoration: const InputDecoration(
//                       labelText: 'Height (meters)',
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType:
//                         const TextInputType.numberWithOptions(decimal: true),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your height';
//                       } else if (double.tryParse(value) == null) {
//                         return 'Please enter a valid number';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   TextFormField(
//                     controller: _weightController,
//                     decoration: const InputDecoration(
//                       labelText: 'Weight (kg)',
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType:
//                         const TextInputType.numberWithOptions(decimal: true),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your weight';
//                       } else if (double.tryParse(value) == null) {
//                         return 'Please enter a valid number';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _calculateBMI,
//                     child: const Text('Calculate BMI'),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 32),
//             if (_bmi != null)
//               Column(
//                 children: [
//                   Text(
//                     'Your BMI is: ${_bmi!.toStringAsFixed(2)}',
//                     style: const TextStyle(fontSize: 24),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Category: $_bmiCategory',
//                     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
