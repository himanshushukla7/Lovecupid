import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../screens/FAQ_screen.dart';

class HelpSupportPopup extends StatelessWidget {
  const HelpSupportPopup({super.key});

  // 🔹 Provide WhatsApp number here later
  static const String? whatsappNumber = null;
  // Example: "919876543210"

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 320.w,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 26.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              Text(
                "Need Help",
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'SF Pro Display',
                ),
              ),

              SizedBox(height: 28.h),

              /// CONTACT US
              GestureDetector(
                onTap: () => _handleContactTap(context),
                child: Text(
                  "Contact us",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: 18.h),

              /// FAQ
              GestureDetector(
                onTap: () => _openFaq(context),
                child: Text(
                  "See The FAQ",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 FAQ NAVIGATION
  void _openFaq(BuildContext context) {
    Navigator.pop(context); // close popup
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const FaqScreen(),
      ),
    );
  }

  /// 🔹 CONTACT (TEMP: ONLY SHOW SNACKBAR)
  void _handleContactTap(BuildContext context) async {
    Navigator.pop(context); // close popup

    // 🚫 WhatsApp launch disabled for now
    _showTopSnackBar(context);

    /*
    if (whatsappNumber == null || whatsappNumber!.isEmpty) {
      _showTopSnackBar(context);
      return;
    }

    final Uri url = Uri.parse("https://wa.me/$whatsappNumber");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showTopSnackBar(context);
    }
    */
  }

  /// 🔹 TOP SNACKBAR
 void _showTopSnackBar(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "TopInfo",
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) {
      return SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE98D6B),
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 25,
                    ),
                  ],
                ),
                child: Text(
                  "WhatsApp support will be enabled once the contact number is provided.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.3),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        )),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );

  /// Auto close after 3 seconds
  Future.delayed(const Duration(seconds: 3), () {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  });
}
}
