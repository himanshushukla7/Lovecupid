import 'dart:ui'; // For ImageFilter
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/bottom_nav_bar.dart';
import '../controller/navigation_controller.dart';
import '../widgets/date_filter_modal_sheet.dart';
import 'match_screen.dart'; 
import 'full_details_screen.dart'; // <--- Ensure this is imported

class LikesScreen extends StatefulWidget {
  final int? forcedIndex;
  const LikesScreen({super.key, this.forcedIndex});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  final int _currentIndex = 1;

  // Data List
  final List<Map<String, String>> _matches = [
    {'image': 'assets/images/m1.jpg', 'name': 'Leilani', 'age': '19'},
    {'image': 'assets/images/m2.jpg', 'name': 'Annabelle', 'age': '20'},
    {'image': 'assets/images/m3.jpg', 'name': 'Reagan', 'age': '24'},
    {'image': 'assets/images/m4.jpg', 'name': 'Hadley', 'age': '25'},
  ];

  // Logic: Remove card from list
  void _removeCard(int index) {
    setState(() {
      _matches.removeAt(index);
    });
  }

  // Logic: Navigate to Match Screen (Heart button)
  void _goToMatchScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MatchScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // --- Header Section ---
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Matches',
                          style: TextStyle(
                            fontSize: 34.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SF Pro Display',
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const DateFilterModalSheet(),
                            );
                          },
                          child: Container(
                            width: 52.w,
                            height: 52.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Icon(
                              Icons.tune_rounded,
                              color: const Color(0xFFEC8E67),
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'This is a list of people who have liked you and your matches.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey.shade600,
                        fontFamily: 'SF Pro Display',
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // "Today" Section Header
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            "Today",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),

              // --- Grid of Matches ---
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.h,
                  crossAxisSpacing: 15.w,
                  childAspectRatio: 0.7, // Taller cards
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final match = _matches[index];
                    return _buildMatchCard(
                      context,
                      image: match['image']!,
                      name: match['name']!,
                      age: match['age']!,
                      index: index,
                    );
                  },
                  childCount: _matches.length, 
                ),
              ),

              // Bottom Spacer
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: widget.forcedIndex ?? 1,
        onTap: (context, index) =>
            NavigationController.navigateTo(context, index, _currentIndex),
      ),
    );
  }

  Widget _buildMatchCard(
    BuildContext context, {
    required String image,
    required String name,
    required String age,
    required int index,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // 1. Gradient Overlay (Bottom)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100.h,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 2. Info Icon (Top Right) - 🔥 ADDED HERE
          Positioned(
            top: 10.h,
            right: 10.w,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullDetailsScreen(
                      name: name,
                      image: image,
                    ),
                  ),
                );
              },
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25), // Subtle dark background
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ),

          // 3. Name and Age
          Positioned(
            bottom: 50.h,
            left: 12.w,
            child: Text(
              "$name, $age",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'SF Pro Display',
              ),
            ),
          ),

          // 4. Action Buttons (Blur Effect)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 45.h,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  child: Row(
                    children: [
                      // ❌ Close Button (Delete)
                      Expanded(
                        child: InkWell(
                          onTap: () => _removeCard(index),
                          child: Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      // Divider
                      Container(
                        width: 1,
                        height: 25.h,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      // ❤️ Heart Button (Navigate)
                      Expanded(
                        child: InkWell(
                          onTap: _goToMatchScreen,
                          child: Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}