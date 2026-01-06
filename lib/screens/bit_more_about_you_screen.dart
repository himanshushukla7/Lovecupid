import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'profile_completion_screen.dart'; // Ensure this file exists

class BitMoreAboutYouScreen extends StatefulWidget {
  const BitMoreAboutYouScreen({super.key});

  @override
  State<BitMoreAboutYouScreen> createState() => _BitMoreAboutYouScreenState();
}

class _BitMoreAboutYouScreenState extends State<BitMoreAboutYouScreen> {
  // Text Controllers
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();

  // Dropdown Selections
  String? _selectedDegree;
  String? _selectedHeight;
  String? _selectedExercise;
  String? _selectedDrinking;
  String? _selectedSmoking;
  String? _selectedRelationship;
  String? _selectedChildren;

  // --- 📝 Predefined Options for Dropdowns ---
  final List<String> _degreeOptions = [
    'High School',
    'Associate',
    'Bachelor',
    'Master',
    'Doctorate',
    'Other'
  ];

  // Generating height list from 140cm to 220cm
  final List<String> _heightOptions = 
      List.generate(81, (index) => '${140 + index} cm');

  final List<String> _frequencyOptions = [
    'Every day',
    'Often',
    'Socially',
    'Rarely',
    'Never'
  ];

  final List<String> _relationshipOptions = [
    'Long-term partner',
    'Long-term, open to short',
    'Short-term, open to long',
    'Short-term fun',
    'New friends',
    'Still figuring it out'
  ];

  final List<String> _childrenOptions = [
    'Want someday',
    'Don\'t want',
    'Have & want more',
    'Have & don\'t want more',
    'Not sure yet'
  ];

  @override
  void dispose() {
    _jobTitleController.dispose();
    _companyController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,

              /// Top Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Custom Back Button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 20.sp,
                        color: const Color(0xFFFF6A3D),
                      ),
                    ),
                  ),

                  // Skip Button
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ProfileCompletionScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: const Color(0xFFFF6A3D),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),

              30.verticalSpace,

              /// Main Title
              Text(
                'A bit more about You',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1,
                ),
              ),

              40.verticalSpace,

              /// --- Work & Education ---
              Text(
                'Work & Education',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              16.verticalSpace,
              _buildTextInput(controller: _jobTitleController, label: 'Job Title'),
              16.verticalSpace,
              _buildTextInput(controller: _companyController, label: 'Company'),
              16.verticalSpace,
              _buildTextInput(controller: _schoolController, label: 'School'),
              16.verticalSpace,
              
              // 🔥 Professional Dropdown
              _buildDropdownInput(
                label: 'Highest Degree',
                value: _selectedDegree,
                items: _degreeOptions,
                onChanged: (val) => setState(() => _selectedDegree = val),
              ),

              30.verticalSpace,

              /// --- Physical Attributes ---
              Text(
                'Physical Attributes',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              16.verticalSpace,
              _buildDropdownInput(
                label: 'Height',
                value: _selectedHeight,
                items: _heightOptions,
                onChanged: (val) => setState(() => _selectedHeight = val),
              ),

              30.verticalSpace,

              /// --- Lifestyle ---
              Text(
                'Lifestyle',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              16.verticalSpace,
              _buildDropdownInput(
                label: 'Exercise Habit',
                value: _selectedExercise,
                items: _frequencyOptions,
                onChanged: (val) => setState(() => _selectedExercise = val),
              ),
              16.verticalSpace,
              _buildDropdownInput(
                label: 'Drinking',
                value: _selectedDrinking,
                items: _frequencyOptions,
                onChanged: (val) => setState(() => _selectedDrinking = val),
              ),
              16.verticalSpace,
              _buildDropdownInput(
                label: 'Smoking',
                value: _selectedSmoking,
                items: _frequencyOptions,
                onChanged: (val) => setState(() => _selectedSmoking = val),
              ),

              30.verticalSpace,

              /// --- Preferences ---
              Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              16.verticalSpace,
              _buildDropdownInput(
                label: 'Relationship Type',
                value: _selectedRelationship,
                items: _relationshipOptions,
                onChanged: (val) => setState(() => _selectedRelationship = val),
              ),
              16.verticalSpace,
              _buildDropdownInput(
                label: 'Children',
                value: _selectedChildren,
                items: _childrenOptions,
                onChanged: (val) => setState(() => _selectedChildren = val),
              ),

              60.verticalSpace,

              /// Confirm Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ProfileCompletionScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEC8E67), // Orange
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  /// 📝 Helper for Text Inputs
  Widget _buildTextInput({
    required TextEditingController controller,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          6.verticalSpace,
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 30.h,
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 12),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔽 UPDATED: Professional Dropdown Input
  Widget _buildDropdownInput({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8), // Light grey background
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          6.verticalSpace,
          // Label
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
            ),
          ),
          // Dropdown Button
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true, // Takes full width
              icon: Icon(
                Icons.arrow_drop_down_rounded,
                color: const Color(0xFFEC8E67), // Orange Icon
                size: 32.sp,
              ),
              hint: Text(
                'Select',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'SF Pro Display', // Ensure your font matches
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
              // Optional: Add menuMaxHeight to prevent extremely long lists covering screen
              menuMaxHeight: 300.h,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ],
      ),
    );
  }
}