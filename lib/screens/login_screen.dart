import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'profile_details_screen.dart'; 

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
        /// 🌍 BACKGROUND IMAGE (Local Asset)
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.jpeg', // 🔥 Using local asset
              fit: BoxFit.cover,
            ),
          ),

          /// ⚫ DARK OVERLAY (Gradient to ensure text readability)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.9),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          /// 📱 CONTENT
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  /// 🔥 INCREASED SPACING to shift content downwards
                  140.verticalSpace, 

                  /// 💟 LOGO
                  Image.asset(
                    'assets/images/lovecupid_logo.png',
                    width: 70.w,
                    height: 70.w,
                    color: Colors.white,
                  ),

                  16.verticalSpace,

                  Text(
                    'LoveCupid',
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),

                  30.verticalSpace,

                  /// 🟡 TITLE
                  Text(
                    'Swipe Right\nMatch Vibe!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFFFD700), // Gold/Yellow color
                      height: 1.1,
                      shadows: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                  ),

                  const Spacer(),

                  /// 🔘 GOOGLE LOGIN BUTTON
                  _socialButton(
                    context: context,
                    text: 'Login with Google',
                    // 🔥 Changed to local asset path
                    iconPath: 'assets/icons/google.png', 
                    color: Colors.white,
                    textColor: Colors.black,
                    onTap: () {
                       Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ProfileDetailsScreen(),
                        ),
                      );
                    },
                  ),

                  16.verticalSpace,

                  /// 🔵 FACEBOOK LOGIN BUTTON
                  _socialButton(
                    context: context,
                    text: 'Login with Facebook',
                    // 🔥 Changed to local asset path
                    iconPath: 'assets/icons/fb.png',
                    color: const Color(0xFF1877F2),
                    textColor: Colors.white,
                    onTap: () {
                       Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ProfileDetailsScreen(),
                        ),
                      );
                    },
                  ),

                  40.verticalSpace,

                  /// 📄 TERMS
                  Text(
                    'By signing up, you agree to our Terms of Service\nand Privacy Policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.6),
                      height: 1.5,
                    ),
                  ),

                  20.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 UPDATED WIDGET to use Image.asset
  Widget _socialButton({
    required BuildContext context,
    required String text,
    required String iconPath, // Renamed for clarity
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
    bool isIconData = false,
    IconData? iconData,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.r), // Pill shape
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ICON
            if (isIconData && iconData != null)
              Icon(iconData, color: textColor, size: 24.sp)
            else
              // 🔥 Changed from Image.network to Image.asset
              Image.asset(
                iconPath,
                width: 24.w,
                height: 24.w,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, color: textColor),
              ),
            
            14.horizontalSpace,
            
            /// TEXT
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}