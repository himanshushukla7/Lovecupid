import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'about_you_screen.dart'; // Ensure this file exists

class InterestsSelectionScreen extends StatefulWidget {
  const InterestsSelectionScreen({super.key});

  @override
  State<InterestsSelectionScreen> createState() =>
      _InterestsSelectionScreenState();
}

class _InterestsSelectionScreenState extends State<InterestsSelectionScreen> {
  // To manage the overlay (prevent stacking multiple messages)
  OverlayEntry? _overlayEntry;

  // Pre-selected interests
  final Set<String> selectedInterests = {
    'Shopping',
    'Run',
    'Traveling',
  };

  final List<String> interests = [
    'Photography',
    'Shopping',
    'Karaoke',
    'Yoga',
    'Cooking',
    'Tennis',
    'Run',
    'Swimming',
    'Art',
    'Traveling',
    'Extreme',
    'Music',
    'Drink',
    'Video games',
  ];

  @override
  void dispose() {
    // Remove overlay if screen is closed while message is showing
    _overlayEntry?.remove();
    super.dispose();
  }

  /// ----------------------------------------------------------------
  /// Logic to show the Top Toast Message
  /// ----------------------------------------------------------------
  void _showTopMessage(BuildContext context) {
    // 1. Remove existing overlay if present so they don't stack
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    // 2. Create the new entry
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10, // Just below status bar
        left: 20.w,
        right: 20.w,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE98862), // Orange background
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline_rounded, color: Colors.white, size: 20.sp),
                10.horizontalSpace,
                Text(
                  'You can only select up to 5 interests',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // 3. Insert into overlay
    Overlay.of(context).insert(_overlayEntry!);

    // 4. Remove after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

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
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AboutScreen(),
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

              Text(
                'Your interests',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              8.verticalSpace,

              Text(
                'Select up to 5 interests and let everyone\nknow what you’re passionate about.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),

              30.verticalSpace,

              /// Interests Chips Grid
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 12.w,
                    runSpacing: 12.h,
                    children: interests.map((interest) {
                      final isSelected = selectedInterests.contains(interest);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedInterests.remove(interest);
                            } else {
                              if (selectedInterests.length < 5) {
                                selectedInterests.add(interest);
                              } else {
                                // TRIGGER THE TOP MESSAGE HERE
                                _showTopMessage(context);
                              }
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFE98862)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : Colors.grey.shade200,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFFE98862)
                                          .withOpacity(0.4),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    )
                                  ]
                                : [],
                          ),
                          width: (1.sw - 48.w - 12.w) / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                _iconForInterest(interest),
                                size: 20.sp,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFFE98862),
                              ),
                              10.horizontalSpace,
                              Expanded(
                                child: Text(
                                  interest,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              20.verticalSpace,

              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: selectedInterests.isEmpty
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AboutScreen(),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE98862),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
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

              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconForInterest(String interest) {
    switch (interest) {
      case 'Photography':
        return Icons.camera_alt_outlined;
      case 'Shopping':
        return Icons.shopping_bag_outlined;
      case 'Karaoke':
        return Icons.mic_none_outlined;
      case 'Yoga':
        return Icons.self_improvement;
      case 'Cooking':
        return Icons.soup_kitchen_outlined;
      case 'Tennis':
        return Icons.sports_tennis;
      case 'Run':
        return Icons.directions_run;
      case 'Swimming':
        return Icons.pool;
      case 'Art':
        return Icons.palette_outlined;
      case 'Traveling':
        return Icons.landscape_outlined;
      case 'Extreme':
        return Icons.paragliding;
      case 'Music':
        return Icons.music_note_outlined;
      case 'Drink':
        return Icons.local_bar_outlined;
      case 'Video games':
        return Icons.sports_esports_outlined;
      default:
        return Icons.star_outline;
    }
  }
}