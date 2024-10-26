import 'package:diet_recall/BMI.dart/heigt_weight_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderScreen extends StatefulWidget {
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  // Index 0 for Female, 1 for Male
  int _selectedGenderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 255, 255, 255), // Set background color to white
      appBar: AppBar(
        title: const Text('Choose One'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Row containing the Male and Female images
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Female image on the left
              GenderImage(
                imagePath: 'assets/female.png', // Change to actual female image
                gender: 'Female',
                selected: _selectedGenderIndex == 0, // Selected state
                onTap: () {
                  setState(() {
                    _selectedGenderIndex = 0;
                  });
                },
              ),
              SizedBox(width: 20),
              // Male image on the right
              GenderImage(
                imagePath: 'assets/male.png', // Change to actual male image
                gender: 'Male',
                selected: _selectedGenderIndex == 1, // Selected state
                onTap: () {
                  setState(() {
                    _selectedGenderIndex = 1;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 40), // Add spacing between the image and slider

          // Gender selector slider (Toggle-like effect)
          GenderSlider(
            selectedIndex: _selectedGenderIndex,
            onChanged: (int index) {
              setState(() {
                _selectedGenderIndex = index;
              });
            },
          ),

          // Button to proceed to the corresponding BMI page
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Navigate to the appropriate BMI page based on selected gender
              if (_selectedGenderIndex == 0) {
                Get.to(HeightWeightScreen(gender: 'Female'));
              } else {
                Get.to(HeightWeightScreen(gender: 'Male'));
              }
            },
            child: Text('Proceed'),
          ),
        ],
      ),
    );
  }
}

class GenderImage extends StatelessWidget {
  final String imagePath;
  final String gender;
  final bool selected;
  final VoidCallback onTap;

  GenderImage({
    required this.imagePath,
    required this.gender,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Container(
          width: 180,
          height: 400,
          decoration: BoxDecoration(
            // color: selected ? Colors.blue.withOpacity(0.2) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 5,
            //     blurRadius: 7,
            //     offset: Offset(0, 3),
            //   ),
            // ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: 390,
                // width: 500,
              ), // Adjust image size
              SizedBox(height: 10),
              // Text(
              //   gender,
              //   style: TextStyle(fontSize: 20, color: Colors.black),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

class GenderSlider extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;

  GenderSlider({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Width of the entire slider
      height: 70, // Height of the slider
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30), // Rounded corners
        border: Border.all(color: Colors.grey.shade300), // Light border
        color: Colors.grey.shade200, // Background color
      ),
      child: Stack(
        children: [
          // Highlight for the selected option
          AnimatedPositioned(
            duration: Duration(milliseconds: 300), // Smooth animation
            curve: Curves.easeInOut,
            left: selectedIndex == 0 ? 0 : 100, // Move the highlight
            child: Container(
              width: 100, // Width for each segment
              height: 70, // Height for each segment
              decoration: BoxDecoration(
                color: Colors.white, // Highlighted color
                borderRadius: BorderRadius.circular(30),
                // border: Border.all(
                //     color: Colors.black) // Rounded for the highlighted part
              ),
            ),
          ),
          // Option Texts (Female and Male)
          Row(
            children: [
              // Female option
              Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(0),
                  child: Center(
                    child: Text(
                      'Female',
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedIndex == 0
                            ? Colors.black // Dark text for selected
                            : Colors.grey, // Light text for unselected
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              // Male option
              Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(1),
                  child: Center(
                    child: Text(
                      'Male',
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedIndex == 1
                            ? Colors.black // Dark text for selected
                            : Colors.grey, // Light text for unselected
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
