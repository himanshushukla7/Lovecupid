import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/navigation_controller.dart'; 
import 'edit_profile_screen.dart';
import 'settings_screen.dart';
import 'privacy_policy_screen.dart';
import '../widgets/help_support_popup.dart';

class ProfileScreen extends StatefulWidget {
  final Widget? contentScreen;
  final int previousIndex;

  const ProfileScreen({
    super.key, 
    this.contentScreen,
    this.previousIndex = 0,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Scale down slightly to show the menu behind
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.75).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Slide to the Left (-220) to reveal menu on the Right
    _slideAnimation = Tween<double>(begin: 0.0, end: -220.w).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _closeDrawerAndNavigate() async {
    await _animationController.reverse();
    if (mounted) {
      NavigationController.navigateTo(
        context, 
        widget.previousIndex, 
        3 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE98D6B), // Peach color from screenshot
      body: Stack(
        children: [
          // ===============================================
          // LAYER 1: BACKGROUND HEARTS (Fixed Placement)
          // ===============================================
          
          // 1. Top Left (Smaller, tucked in corner)
         // ... inside your Stack
Positioned(
  top: -26.h,   // Figma Y: -26
  left: -43.w,  // Figma X: -43
  child: Transform.rotate(
    angle: -35.32 * (pi / 180), // Figma Rotation: -35.32° converted to radians
    child: Icon(
      Icons.favorite,
      size: 126.sp, // Figma Size: W 126, H 126
      color: Colors.white.withOpacity(0.1),
    ),
  ),
),
          // 2. Top Right (Smaller, tucked in corner)
          Positioned(
            top: -40.h,
            right: -40.w,
            child: Transform.rotate(
              angle: pi / 6, 
              child: Icon(
                Icons.favorite,
                size: 126.sp, // Reduced size
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),

          // 3. Bottom Left (Visible, Tip touching corner)
          Positioned(
            bottom: -20.h, // Slight negative to touch edge nicely
            left: -20.w,  
            child: Transform.rotate(
              angle: -pi / 4, // 45 degrees to point tip into corner
              child: Icon(
                Icons.favorite,
                size: 126.sp, // Fully visible size
                color: Colors.white.withOpacity(0.15), // Slightly more visible
              ),
            ),
          ),

          // 4. Bottom Right (Large anchor background)
Positioned(
  top: 671.h,   // Figma Y: 671
  left: 238.w,  // Figma X: 238
  child: Transform.rotate(
    angle: 36.04 * (pi / 180), // Figma Rotation: 36.04°
    child: Icon(
      Icons.favorite,
      size: 126.sp, // Figma Size: W 126, H 126
      color: Colors.white.withOpacity(0.1),
    ),
  ),
),
          // ===============================================
          // LAYER 2: THE MENU (Right Aligned)
          // ===============================================
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 35.w, top: 150.h), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, 
                children: [
                  _buildMenuItem('Profile', () {
                    print("Clicked Profile");
Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                  }),
                  _buildMenuItem('Settings', () {
                    print("Clicked Profile");
Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));                  }),
                  _buildMenuItem('Privacy&Policy', () {
                    print("Clicked Profile");
Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));                  }),
                  
                  _buildMenuItem('Help & Support', () {
                    print("Clicked Profile");
showDialog(
  context: context,
  barrierDismissible: true,
  builder: (_) => const HelpSupportPopup(),
);
                 }),
                  
                  
                  //SizedBox(height: 30.h), 
                  
                  _buildMenuItem('Log out', () {
                    print("Clicked Profile");
                    // Example: _navigateToPage(const EditProfileScreen());
                  }),
                ],
              ),
            ),
          ),

          // ===============================================
          // LAYER 3: FOREGROUND SCREEN
          // ===============================================
          if (widget.contentScreen != null)
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.centerRight, 
                  transform: Matrix4.identity()
                    ..translate(_slideAnimation.value)
                    ..scale(_scaleAnimation.value),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35.r), 
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 30,
                            offset: const Offset(10, 10),
                          )
                        ]
                      ),
                      child: GestureDetector(
                        onTap: _closeDrawerAndNavigate, 
                        behavior: HitTestBehavior.translucent, 
                        child: IgnorePointer(
                          ignoring: true, 
                          child: widget.contentScreen,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  // Helper to build the Menu Text + Dashed Line
  // ---------------------------------------------------------------------------
  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // 👈 Calls the function passed above
      behavior: HitTestBehavior.translucent, // Ensures the tap works even on empty space around text
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'SF Pro Display',
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              width: 100.w,
              child: _buildDashedLine(),
            ),
          ],
        ),
      ),
    );
  }
  // Custom Dashed Line Generator
  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashHeight = 1.5;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.6)),
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