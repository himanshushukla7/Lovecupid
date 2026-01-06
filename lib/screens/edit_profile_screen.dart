import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import your actual screens here. 
// For this example, I have added placeholder classes at the bottom of this file.
import 'about_you_screen.dart';
import 'add_photos_screen.dart';
import 'gender_selection_screen.dart';
import 'interests_selection_screen.dart';
import 'bit_more_about_you_screen.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Match background
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              
              // 1. Top Bar (Back Button + Title)
              Stack(
                alignment: Alignment.center,
                children: [
                  // Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 20.sp,
                          color: const Color(0xFFE98D6B), // Orange tint from image
                        ),
                      ),
                    ),
                  ),
                  
                  // Title
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              // 2. "Edit Your Profile" Header
              Text(
                "Edit Your Profile",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE98D6B), // Orange color
                ),
              ),

              SizedBox(height: 30.h),

              // 3. Menu Items List
              Expanded(
                child: ListView(
                  children: [
                    _buildProfileItem(
                      context,
                      title: "Add Photo's",
                      onTap: () => _navigateTo(context, const AddPhotosScreen()),
                    ),
                    _buildProfileItem(
                      context,
                      title: "Your Gender",
                      onTap: () => _navigateTo(context, const GenderSelectionScreen()),
                    ),
                    _buildProfileItem(
                      context,
                      title: "Your Interests",
                      onTap: () => _navigateTo(context, const InterestsSelectionScreen()),
                    ),
                    _buildProfileItem(
                      context,
                      title: "About Yourself",
                      onTap: () => _navigateTo(context, const AboutScreen()),
                    ),
                    _buildProfileItem(
                      context,
                      title: "Work & Education",
                      // Maps to BitMoreAboutYouScreen
                      onTap: () => _navigateTo(context, const BitMoreAboutYouScreen()),
                    ),
                    _buildProfileItem(
                      context,
                      title: "Physical Attributes",
                       // Maps to BitMoreAboutYouScreen
                      onTap: () => _navigateTo(context, const BitMoreAboutYouScreen()),
                    ),
                    _buildProfileItem(
                      context,
                      title: "Lifestyle",
                       // Maps to BitMoreAboutYouScreen
                      onTap: () => _navigateTo(context, const BitMoreAboutYouScreen()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to navigate
  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Widget for each Menu Item
  Widget _buildProfileItem(BuildContext context, {required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.only(bottom: 25.h), // Spacing between items
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18.sp,
                  color: const Color(0xFFE98D6B), // Orange arrow color
                ),
              ],
            ),
            SizedBox(height: 15.h),
            // The Dotted/Dashed Line Divider
            _buildDashedLine(),
          ],
        ),
      ),
    );
  }

  // Custom Dashed Line Widget
  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

