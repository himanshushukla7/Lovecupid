import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'interests_selection_screen.dart'; // Ensure this file exists

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  // 'Man' is selected by default in your code
  String selectedGender = 'Man'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,

              /// Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
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
                        color: const Color(0xFFFF6A3D), // Orange icon
                      ),
                    ),
                  ),
                  
                  // Skip Button
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const InterestsSelectionScreen(),
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

              40.verticalSpace,

              /// Title
              Text(
                'I am a',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              40.verticalSpace,

              /// Options
              _genderTile('Woman'),
              16.verticalSpace,
              _genderTile('Man'),
              16.verticalSpace,
              // Renamed to 'Other' and now uses standard selection logic
              _genderTile('Other'),

              const Spacer(),

              /// Continue Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: selectedGender.isEmpty
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const InterestsSelectionScreen(),
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
                    'Continue',
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

  Widget _genderTile(String gender) {
    final isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() => selectedGender = gender);
      },
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          // Orange if selected, Light Grey if not
          color: isSelected ? const Color(0xFFEC8E67) : const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              gender,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            
            // Standardized Icon Logic:
            // All options (Woman, Man, Other) now show the checkmark if selected.
            if (isSelected)
              Icon(
                Icons.check,
                color: Colors.white,
                size: 24.sp,
              )
          ],
        ),
      ),
    );
  }
}