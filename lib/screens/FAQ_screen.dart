import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

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

              // 1. Top Bar (Custom layout for Title + Subtitle)
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
                  
                  // Title & Subtitle
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "FAQ",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "(Frequently Asked Question)",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              // 2. FAQ List
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFaqItem(
                        question: "What is Love Cupid?",
                        answer: "Love Cupid is a dating app that helps people connect, chat, and build meaningful relationships.",
                      ),
                      _buildFaqItem(
                        question: "Who can use Love Cupid?",
                        answer: "You must be 18 years or older to use Love Cupid.",
                      ),
                      _buildFaqItem(
                        question: "Is Love Cupid free to use?",
                        answer: "Love Cupid may offer free features and optional paid features. Any paid features will be clearly explained in the app.",
                      ),
                      _buildFaqItem(
                        question: "How do matches work?",
                        answer: "Matches are suggested based on your profile information, preferences, and location.",
                      ),
                      _buildFaqItem(
                        question: "Is my data safe?",
                        answer: "We take reasonable steps to protect your data. Please read our Privacy Policy to understand how your information is used.",
                      ),
                      _buildFaqItem(
                        question: "Can other users see my personal information?",
                        answer: "Other users can only see the profile information you choose to make public.",
                      ),
                      _buildFaqItem(
                        question: "How do I delete my account?",
                        answer: "You can delete your account anytime from the app settings. Once deleted, your data will be removed as described in our Privacy Policy.",
                      ),
                      _buildFaqItem(
                        question: "Can I block or report someone?",
                        answer: "Yes. You can block or report users directly within the app to help keep the community safe.",
                      ),
                      _buildFaqItem(
                        question: "Does Love Cupid verify users?",
                        answer: "Some verification features may be available, but Love Cupid does not guarantee the identity of users. Always use caution when interacting with others.",
                      ),
                      
                      SizedBox(height: 40.h), // Bottom padding
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

  // Helper Widget for FAQ Items
  Widget _buildFaqItem({required String question, required String answer}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold, // Bold Question
              color: const Color(0xFFE98D6B), // Theme Orange
              fontFamily: 'SF Pro Display',
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            answer,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.4, // Readable line height
              color: Colors.black, // Regular Black Answer
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}