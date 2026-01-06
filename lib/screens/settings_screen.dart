import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'termsConditionsScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // 1. UPDATED: All options default to false (OFF)
  bool _notification = false;
  bool _information = false;
  bool _photos = false;
  bool _location = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              // 1. Top Bar
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F9F9), 
                          border: Border.all(color: Colors.grey.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18.sp,
                          color: const Color(0xFFE98D6B),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Setting",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              // 2. Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Group 1: Toggles ---
                      _buildToggleItem(
                        title: "Notification",
                        subtitle: "Never Miss What is happening",
                        value: _notification,
                        onChanged: (val) => setState(() => _notification = val),
                      ),
                      _buildToggleItem(
                        title: "Information",
                        subtitle: "Show All Information To others",
                        value: _information,
                        onChanged: (val) => setState(() => _information = val),
                      ),
                      _buildToggleItem(
                        title: "Photos",
                        subtitle: "Show All Photos To others",
                        value: _photos,
                        onChanged: (val) => setState(() => _photos = val),
                      ),
                      _buildToggleItem(
                        title: "Location",
                        subtitle: "Share My Current Location",
                        value: _location,
                        onChanged: (val) => setState(() => _location = val),
                      ),

                      SizedBox(height: 10.h),
                      
                      // --- Divider ---
                      _buildDashedLine(),
                      
                      SizedBox(height: 30.h),

                      // --- Group 2: Navigation ---
                      _buildNavItem(
  title: "Terms & Conditions",
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TermsConditionsScreen(),
      ),
    );
  },
),

                      _buildNavItem(
                        title: "Delete My Account",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Footer Version
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Items with Switches
  Widget _buildToggleItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white, // The circle (thumb) remains white
              // 2. UPDATED: Active track color is now the theme orange
              activeTrackColor: const Color(0xFFE98D6B), 
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[200],
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.only(bottom: 25.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: const Color(0xFFE98D6B),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
              ),
            );
          }),
        );
      },
    );
  }
}