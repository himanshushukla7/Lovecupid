import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'profile_details_screen.dart'; 
import 'enable_notification_screen.dart';

// 1. Changed to StatefulWidget to handle the "Read More" toggle state
class ProfileCompletionScreen extends StatefulWidget {
  const ProfileCompletionScreen({super.key});

  @override
  State<ProfileCompletionScreen> createState() =>
      _ProfileCompletionScreenState();
}

class _ProfileCompletionScreenState extends State<ProfileCompletionScreen> {
  // 2. State variable to track text expansion
  bool _isExpanded = false;

  // 3. Full bio text
  final String _fullBio =
      "I'm a creative soul with a passion for photography and exploring new cultures. "
      "Looking for someone who enjoys weekend hikes, coffee shop hopping, and deep conversations "
      "about the universe. Let's create beautiful memories together!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: Column(
          children: [
            /// 1. Top Bar (Edit Button)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ProfileDetailsScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: const Color(0xFFFF6A3D),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),

            /// 2. Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Profile Completion',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1.2,
                      ),
                    ),
                    24.verticalSpace,

                    // Profile Image
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: 350.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          color: Colors.grey.shade300,
                          image: const DecorationImage(
                            image: AssetImage('assets/images/p1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    20.verticalSpace,

                    // Name & Age
                    Text(
                      'Jessica Parker, 23',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    4.verticalSpace,

                    // Location
                    Text(
                      'San Francisco, CA',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    24.verticalSpace,

                    // --- Section: About (Interactive) ---
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    8.verticalSpace,
                    
                    // 4. Interactive Read More Logic
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 200),
                        crossFadeState: _isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        
                        // First Child: Collapsed View
                        firstChild: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                              height: 1.5,
                              fontFamily: 'sans-serif',
                            ),
                            children: [
                              TextSpan(
                                // Show first 90 characters
                                text: _fullBio.length > 90 
                                    ? '${_fullBio.substring(0, 90)}... ' 
                                    : _fullBio,
                              ),
                              const TextSpan(
                                text: 'See more',
                                style: TextStyle(
                                  color: Color(0xFFFF6A3D),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Second Child: Expanded View
                        secondChild: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                              height: 1.5,
                              fontFamily: 'sans-serif',
                            ),
                            children: [
                              TextSpan(text: '$_fullBio '),
                              const TextSpan(
                                text: 'See less',
                                style: TextStyle(
                                  color: Color(0xFFFF6A3D),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    24.verticalSpace,

                    // --- Section: Interests ---
                    Text(
                      'Interests',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    12.verticalSpace,
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: [
                        _buildInterestChip('Run', Icons.directions_run),
                        _buildInterestChip(
                            'Shopping', Icons.shopping_bag_outlined),
                        _buildInterestChip(
                            'Traveling', Icons.landscape_outlined),
                      ],
                    ),
                    24.verticalSpace,

                    // --- Section: Lifestyle ---
                    Text(
                      'Lifestyle',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                            child: _buildLifestyleBox('Drinks', 'Socially')),
                        12.horizontalSpace,
                        Expanded(child: _buildLifestyleBox('Smokes', 'Never')),
                      ],
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        Expanded(child: _buildLifestyleBox('Kids', 'No')),
                        12.horizontalSpace,
                        Expanded(child: _buildLifestyleBox('Pets', 'Dog')),
                      ],
                    ),

                    40.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      /// 3. Fixed Confirm Button
      bottomNavigationBar: Container(
        padding:
            EdgeInsets.only(left: 24.w, right: 24.w, bottom: 40.h, top: 10.h),
        color: const Color(0xFFFDFDFD),
        child: SizedBox(
          height: 54.h,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const EnableNotificationScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF9A6C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Confirm',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInterestChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9A6C),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF9A6C).withOpacity(0.3),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18.sp),
          8.horizontalSpace,
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifestyleBox(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          4.verticalSpace,
          Text(
            value,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}