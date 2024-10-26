import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bmi_result_screen.dart';

class HeightWeightScreen extends StatefulWidget {
  final String gender;

  const HeightWeightScreen({required this.gender});

  @override
  _HeightWeightScreenState createState() => _HeightWeightScreenState();
}

class _HeightWeightScreenState extends State<HeightWeightScreen> {
  double _height = 160;
  double _weight = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your height & weight'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const SizedBox(height: 20),
          // const Text(
          //   'Your height & weight',
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Weight slider on the left
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.purple,
                          inactiveTrackColor: Colors.purple.shade100,
                          thumbColor: Colors.purple,
                          overlayColor: Colors.purple.withOpacity(0.2),
                          trackHeight: 6.0,
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 8.0),
                        ),
                        child: Slider(
                          value: _weight,
                          min: 30,
                          max: 150,
                          divisions: 120,
                          onChanged: (value) {
                            setState(() {
                              _weight = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${_weight.round()} kg',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Weight',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                // Character image in the center
                Image.asset(
                  'assets/${widget.gender.toLowerCase()}.png',
                  height: 370,
                ),
                // Height slider on the right
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.purple,
                          inactiveTrackColor: Colors.purple.shade100,
                          thumbColor: Colors.purple,
                          overlayColor: Colors.purple.withOpacity(0.2),
                          trackHeight: 6.0,
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 8.0),
                        ),
                        child: Slider(
                          value: _height,
                          min: 100,
                          max: 220,
                          divisions: 120,
                          onChanged: (value) {
                            setState(() {
                              _height = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${_height.round()} cm',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Height',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              double bmi = _weight / ((_height / 100) * (_height / 100));
              Get.to(BmiResultScreen(bmi: bmi, gender: widget.gender));
            },
            child: const Icon(Icons.arrow_forward, color: Colors.white),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(), backgroundColor: Colors.pink,
              padding: const EdgeInsets.all(16), // Background color
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
