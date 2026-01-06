import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showChatOptionsBottomSheet({
  required BuildContext context,
  VoidCallback? onReport,
  VoidCallback? onUnmatch,
  VoidCallback? onServiceCentre,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: false,
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFDFD),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 24.h),

            _optionTile(
              icon: Icons.flag,
              iconColor: Colors.red,
              title: "Report",
              subtitle:
                  "Report you are no longer matched or see as illegal.",
              onTap: () {
                Navigator.pop(context);
                onReport?.call();
              },
            ),

            _optionTile(
              icon: Icons.close,
              iconColor: Colors.deepOrange,
              title: "Unmatch",
              subtitle:
                  "Unmatch if you don't find the other person comfortable.",
              onTap: () {
                Navigator.pop(context);
                onUnmatch?.call();
              },
            ),

            _optionTile(
              icon: Icons.shield_outlined,
              iconColor: Colors.deepPurple,
              title: "Service Centre",
              subtitle:
                  "Check how to use the features of Lovecupid and your privacy.",
              onTap: () {
                Navigator.pop(context);
                onServiceCentre?.call();
              },
            ),
          ],
        ),
      );
    },
  );
}

/// ----------------------------
/// Option Tile Widget
/// ----------------------------
Widget _optionTile({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: iconColor),
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SF Pro Display',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey,
                    height: 1.4,
                    fontFamily: 'SF Pro Display',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
