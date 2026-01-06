import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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

              // 1. Top Bar (Consistent with Settings Screen)
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
                          color: const Color(0xFFE98D6B), // Theme Orange
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              // 2. Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Section 1: Intro ---
                      _buildSectionTitle("Privacy Policy"),
                      _buildBodyText(
                        "Effective Date: [Insert Date]\n"
                        "Love Cupid (\"we,\" \"our,\" or \"us\") respects your privacy. This policy explains how we handle your information when you use our dating app."
                      ),
                      
                      SizedBox(height: 20.h),

                      // --- Section 2: What We Collect ---
                      _buildSectionTitle("What We Collect"),
                      _buildBulletPoint("Basic account and profile details you choose to share"),
                      _buildBulletPoint("Photos, bio, interests, and preferences"),
                      _buildBulletPoint("Location data (with permission)"),
                      _buildBulletPoint("App usage, device, and log information"),
                      _buildBulletPoint("Messages and support communications"),

                      SizedBox(height: 20.h),

                      // --- Section 3: How We Use It ---
                      _buildSectionTitle("How We Use It"),
                      _buildBulletPoint("To operate and improve the app"),
                      _buildBulletPoint("To show matches and enable chats"),
                      _buildBulletPoint("To maintain safety and prevent abuse"),
                      _buildBulletPoint("To communicate updates and support"),

                      SizedBox(height: 20.h),

                      // --- Section 4: Sharing ---
                      _buildSectionTitle("Sharing"),
                      _buildBodyText("We do not sell your data. Information is shared only:"),
                      SizedBox(height: 5.h),
                      _buildBulletPoint("With other users (profile info you make visible)"),
                      _buildBulletPoint("With trusted service providers"),
                      _buildBulletPoint("When required by law or for safety"),

                      SizedBox(height: 20.h),

                      // --- Section 5: Your Rights ---
                      _buildSectionTitle("Your Rights"),
                      _buildBodyText(
                        "You can access, update, or delete your account at any time through the app."
                      ),

                      SizedBox(height: 20.h),

                      // --- Section 6: Age Limit & Updates (Mixed) ---
                      Text(
                        "Age Limit",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black, // Appears black in screenshot
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      _buildBodyText("Love Cupid is for users 18+ only."),
                      
                      SizedBox(height: 15.h),
                      
                      Text(
                        "Updates",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      _buildBodyText(
                        "We may update this policy. Continued use means acceptance of changes."
                      ),

                      SizedBox(height: 20.h),

                      // --- Section 7: Contact ---
                      _buildSectionTitle("Contact"),
                      _buildBodyText(
                        "Love Cupid\n"
                        "Email: [support@lovecupid.com]\n"
                        "This is a simplified privacy policy and not legal advice."
                      ),
                      
                      // Bottom padding for safe scrolling
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Orange Section Titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFE98D6B), // Theme Orange
          fontFamily: 'SF Pro Display',
        ),
      ),
    );
  }

  // Helper Widget for Regular Body Text
  Widget _buildBodyText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        height: 1.5, // Good line height for readability
        color: Colors.black,
        fontFamily: 'SF Pro Display',
      ),
    );
  }

  // Helper Widget for Bullet Points
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, right: 8.w),
            child: Icon(Icons.circle, size: 5.sp, color: Colors.black),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.5,
                color: Colors.black,
                fontFamily: 'SF Pro Display',
              ),
            ),
          ),
        ],
      ),
    );
  }
}