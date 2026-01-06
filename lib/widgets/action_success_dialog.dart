import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showActionSuccessDialog({
  required BuildContext context,
  required String title,
  required String message,
  IconData icon = Icons.check_rounded,
  Color iconColor = const Color(0xFF22C55E),
  String buttonText = "Okay",
  VoidCallback? onButtonTap,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Card
            Container(
              padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 24.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SF Pro Display',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                      height: 1.5,
                      fontFamily: 'SF Pro Display',
                    ),
                  ),
                  SizedBox(height: 28.h),

                  // Primary Button (BRAND COLOR ONLY)
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onButtonTap?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF29B72),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF Pro Display',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Close Button
            Positioned(
              top: 16.h,
              right: 16.w,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 18.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),

            // Top Icon Badge
            Positioned(
              top: -36.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 76.w,
                  height: 76.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconColor.withOpacity(0.15),
                  ),
                  child: Center(
                    child: Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: iconColor,
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
