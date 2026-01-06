import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'preview_screen.dart'; 
import 'chat_detail_screen.dart';

class FullDetailsScreen extends StatelessWidget {
  final String name;
  final String image;

  const FullDetailsScreen({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // Standardize spacing variables
    final double horizontalPadding = 24.w;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- 1. Background Image ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 0.46.sh, 
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfilePreviewScreen(selectedImage: image),
                  ),
                );
              },
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          // --- 2. Custom Back Button ---
          Positioned(
            top: 50.h,
            left: horizontalPadding,
            child: GestureDetector(
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
              Icons.chevron_left_rounded,
              color: const Color(0xFFEC8E67),
              size: 28.sp,
            ),
          ),
            ),
          ),

          // --- 3. White Scrollable Body ---
          Positioned.fill(
            top: 0.40.sh, 
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36.r),
                  topRight: Radius.circular(36.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(horizontalPadding, 85.h, horizontalPadding, 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Job
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$name, 23",
                              style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'SF Pro Display',
                                color: const Color(0xFF1A1A1A),
                                height: 1.0,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "Professional model",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: 'SF Pro Display',
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
// 🟢 THIS IS THE UPDATED PART 🟢
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatDetailScreen(name: name, image: image),
                              ),
                            );
                          },
                          child: Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(color: Colors.grey.shade200),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(10.w),
                            child: SvgPicture.asset(
                              'assets/icons/send.svg',
                              colorFilter: const ColorFilter.mode(
                                Color(0xFFEC8E67),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25.h),

                    // Location
                    Row(
                      children: [
                       // Icon(Icons.location_on_rounded, color: const Color(0xFFEC8E67), size: 18.sp),
                        //SizedBox(width: 6.w),
                        Text(
                          "Chicago, IL United States",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'SF Pro Display',
                            color: const Color(0xFF4A4A4A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                     Container(
  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
  decoration: BoxDecoration(
    color: const Color(0xFFEC8E67).withOpacity(0.08),
    borderRadius: BorderRadius.circular(20.r),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        Icons.location_on_rounded,
        color: const Color(0xFFEC8E67),
        size: 16.sp,
      ),
      SizedBox(width: 4.w),
      Text(
        "1 km",
        style: TextStyle(
          color: const Color(0xFFEC8E67),
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  ),
),

                      ],
                    ),

                    SizedBox(height: 30.h),

                    // About
                    _buildSectionTitle("About"),
                    SizedBox(height: 12.h),
                    Text(
                      "My name is $name and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading...",
                      style: TextStyle(
                        fontSize: 15.sp,
                        height: 1.6,
                        color: Colors.grey.shade600,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Read more",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFEC8E67),
                        fontFamily: 'SF Pro Display',
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Interests
                    _buildSectionTitle("Interests"),
                    SizedBox(height: 16.h),
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: [
                        _buildInterestChip("Travelling", true),
                        _buildInterestChip("Books", true),
                        _buildInterestChip("Music", false),
                        _buildInterestChip("Dancing", false),
                        _buildInterestChip("Modeling", false),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    // Gallery Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSectionTitle("Gallery"),
                        Text(
                          "See all",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFEC8E67),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    
                    // --- 🟢 NEW GALLERY LAYOUT (2 then 3) ---
                    Column(
                      children: [
                        // Row 1: Two Images
                        Row(
                          children: [
                            Expanded(child: _buildGalleryItem('assets/images/p1.png', height: 160.h)),
                            SizedBox(width: 10.w),
                            Expanded(child: _buildGalleryItem('assets/images/p2.png', height: 160.h)),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        // Row 2: Three Images
                        Row(
                          children: [
                            Expanded(child: _buildGalleryItem('assets/images/p3.jpg', height: 100.h)),
                            SizedBox(width: 10.w),
                            Expanded(child: _buildGalleryItem('assets/images/p4.png', height: 100.h)),
                            SizedBox(width: 10.w),
                            Expanded(child: _buildGalleryItem('assets/images/p7.jpg', height: 100.h)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 100.h), // Extra space at bottom
                  ],
                ),
              ),
            ),
          ),

          // --- 4. Floating Action Buttons ---
          Positioned(
            top: 0.40.sh - 35.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  icon: Icons.close,
                  color: const Color(0xFFEC8E67),
                  bg: Colors.white,
                  size: 60.w,
                  iconSize: 24.sp,
                ),
                SizedBox(width: 30.w),
                _buildActionButton(
                  icon: Icons.favorite,
                  color: Colors.white,
                  bg: const Color(0xFFEC8E67),
                  size: 75.w,
                  iconSize: 32.sp,
                  hasShadow: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        fontFamily: 'SF Pro Display',
        color: const Color(0xFF1A1A1A),
      ),
    );
  }

  // 🟢 CHANGED: Rectangular Chips
  Widget _buildInterestChip(String label, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        // Changed radius to 8.r (Rectangular look) from 25.r (Pill look)
        borderRadius: BorderRadius.circular(8.r), 
        border: Border.all(
          color: isActive ? const Color(0xFFEC8E67) : Colors.grey.shade300,
          width: 1.2,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          color: isActive ? const Color(0xFFEC8E67) : Colors.grey.shade600,
          fontFamily: 'SF Pro Display',
        ),
      ),
    );
  }

  Widget _buildGalleryItem(String img, {double? height}) {
    return SizedBox(
      height: height ?? 120.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.asset(img, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required Color bg,
    required double size,
    required double iconSize,
    bool hasShadow = false,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          if (hasShadow)
            BoxShadow(
              color: const Color(0xFFEC8E67).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
        ],
      ),
      child: Icon(icon, color: color, size: iconSize),
    );
  }
}