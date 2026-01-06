import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSlideMenu extends StatelessWidget {
  final Animation<double> animation;
  final VoidCallback onClose;

  const ProfileSlideMenu({
    super.key,
    required this.animation,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.75;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          top: 0,
          bottom: 0,
          right: -width + (width * animation.value),
          child: Material(
            elevation: 16,
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              bottomLeft: Radius.circular(24.r),
            ),
            child: SizedBox(
              width: width,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profile Menu',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: onClose,
                          ),
                        ],
                      ),
                    ),

                    const Divider(),

                    /// Menu Items
                    _menuItem(Icons.person, 'My Profile'),
                    _menuItem(Icons.settings, 'Settings'),
                    _menuItem(Icons.help_outline, 'Help'),
                    _menuItem(Icons.logout, 'Logout'),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 22),
          12.horizontalSpace,
          Text(
            title,
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
