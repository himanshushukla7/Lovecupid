import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(BuildContext context, int index) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Get the system navigation bar height
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      // 2. Reduced base height from 80.h to 60.h
      height: 60.h + bottomPadding, 
      
      // 3. Keep padding to push icons up away from system buttons
      padding: EdgeInsets.only(bottom: bottomPadding),
      
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, 0, 'assets/icons/cards.png'),
          _buildNavItem(context, 1, 'assets/icons/like.png'),
          _buildNavItem(context, 2, 'assets/icons/message.png'),
          _buildNavItem(context, 3, 'assets/icons/people.png'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, String iconPath) {
    final bool isActive = currentIndex == index;
    const primaryColor = Color(0xFFEC8E67);

    return GestureDetector(
      onTap: () => onTap(context, index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        // 4. Reduced touch target height to match the new container base height
        height: 60.h, 
        width: 70.w, 
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. The Flashlight Effect
            if (isActive)
              Positioned(
                top: 0,
                child: Column(
                  children: [
                    // The "Source" dash (Top)
                    Container(
                      width: 32.w, 
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4.r),
                          bottomRight: Radius.circular(4.r),
                        ),
                      ),
                    ),
                    // The "Scattered Beam" (Custom Painter)
                    CustomPaint(
                      // Reduced beam height slightly (45 -> 40) to fit better in 60h
                      size: Size(80.w, 40.h), 
                      painter: FlashlightPainter(color: primaryColor),
                    ),
                  ],
                ),
              ),

            // 2. The Icon
            Image.asset(
              iconPath,
              width: 24.w,
              height: 24.w,
              color: isActive ? primaryColor : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

class FlashlightPainter extends CustomPainter {
  final Color color;

  FlashlightPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withOpacity(0.3), 
          color.withOpacity(0.0), 
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();

    // Define the trapezoid shape
    double topWidth = size.width * 0.4; 
    double centerX = size.width / 2;

    path.moveTo(centerX - (topWidth / 2), 0); 
    path.lineTo(centerX + (topWidth / 2), 0); 
    path.lineTo(size.width, size.height);     
    path.lineTo(0, size.height);              
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}