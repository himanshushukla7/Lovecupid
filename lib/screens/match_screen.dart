import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'chat_screen.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using 375x812 design base from Figma
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(flex: 1),

              // --- The Card Stack ---
              // Height increased to 450 to accommodate the wide spread in Figma
              SizedBox(
                height: 450.h,
                width: 375.w,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // 1. Right Card (Man) - UP
                    // Figma: left: 177, top: 78
                    Positioned(
                      left: 177.w, 
                      top: 30.h, // Shifted UP to match visual gap
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateZ(0.17), // ~9.7 degrees
                        child: _buildFigmaCard('assets/images/p3.jpg'),
                      ),
                    ),

                    // 2. Left Card (Woman) - DOWN
                    // Figma: left: 40, top: 197
                    Positioned(
                      left: 40.w,
                      top: 150.h, // Shifted DOWN to create the distinct gap
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateZ(-0.17), // ~-9.7 degrees
                        child: _buildFigmaCard('assets/images/p9.jpg'),
                      ),
                    ),

                    // 3. Top Heart Bubble
                    // Figma: left: 162, top: 53
                    Positioned(
                      left: 155.w,
                      top: 0.h, // Floating at the very top
                      child: _buildFigmaHeartBubble(),
                    ),

                    // 4. Bottom Heart Bubble
                    // Figma: left: 56, top: 397
                    Positioned(
                      left: 50.w,
                      bottom: 40.h, // Anchored near the bottom of the stack area
                      child: _buildFigmaHeartBubble(),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // --- Text & Buttons ---
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  children: [
                    Text(
                      'It’s a match, Jake!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFEF946C), // Figma Orange
                        fontSize: 34.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Start a conversation now with each other',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.70),
                        fontSize: 14.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    
                    // Button 1
                   _buildFigmaButton(
                      text: "Say hello",
                      bgColor: const Color(0xFFEF946C),
                      textColor: Colors.white,
                      onTap: () {
                        // 🔥 Navigation Logic Added Here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    
                    // Button 2
                    _buildFigmaButton(
                      text: "Keep swiping",
                      bgColor: const Color(0xFFEF946C).withOpacity(0.10),
                      textColor: const Color(0xFFEF946C),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFigmaCard(String imagePath) {
    return Container(
      width: 160.w,  // Figma Width
      height: 240.h, // Figma Height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x26000000),
            blurRadius: 25,
            offset: const Offset(0, 25),
            spreadRadius: 0,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) => Container(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildFigmaHeartBubble() {
    return Container(
      width: 64.w,  // Increased size for visibility
      height: 64.w,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F5), // Cutout effect color
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0x11000000), // Soft wide shadow
            blurRadius: 50,
            offset: const Offset(0, 20),
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // The inner colored shadow/glow from Figma
            boxShadow: [
              BoxShadow(
                color: const Color(0x33E94057),
                blurRadius: 15,
                offset: const Offset(0, 15),
              )
            ],
          ),
          child: Icon(
            Icons.favorite_rounded,
            color: const Color(0xFFEF946C),
            size: 30.sp, // Bigger Icon
          ),
        ),
      ),
    );
  }

  Widget _buildFigmaButton({
    required String text,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 295.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16.sp,
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}