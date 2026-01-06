import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'enable_location_screen.dart';

class EnableNotificationScreen extends StatelessWidget {
  const EnableNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              /// 1. Skip Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigate to Home or Next Screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const EnableLocationScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: const Color(0xFFFF6A3D),
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),

              /// 2. Chat Icon
              // Using the requested asset
              Image.asset(
                'assets/images/chat.png',
                width: 180.w, 
                height: 180.w,
                fit: BoxFit.contain,
              ),

              40.verticalSpace,

              /// 3. Title
              Text(
                "Enable notification's",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),

              12.verticalSpace,

              /// 4. Subtitle
              Text(
                'Get push-notification when you get the match or\nreceive a message.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const Spacer(flex: 3),

              /// 5. Main Button
              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic to request notification permissions
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const EnableLocationScreen(),
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
                    'I want to be notified',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}