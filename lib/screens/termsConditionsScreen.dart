import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  static const Color primaryPeach = Color(0xFFE98D6B);
  static const Color background = Color(0xFFF9FAF7);
  static const Color textDark = Color(0xFF1E1E1E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),

              /// TOP BAR
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 44.w,
                      width: 44.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18.sp,
                        color: primaryPeach,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Terms & Conditions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),

              SizedBox(height: 24.h),

              /// CONTENT
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      _sectionTitle('Terms & Conditions'),
                      _bodyText(
                        'Effective Date: [Insert Date]\n'
                        'Welcome to Love Cupid. By accessing or using our dating app, '
                        'you agree to these Terms & Conditions ("Terms"). If you do not agree, '
                        'please do not use the app.',
                      ),

                      _sectionTitle('Eligibility'),
                      _bullet('You must be 18 years or older to use Love Cupid.'),
                      _bullet(
                        'By using the app, you confirm that all information you provide is accurate and truthful.',
                      ),

                      _sectionTitle('Use of the App'),
                      _bodyText('You agree to:'),
                      _bullet('Use the app for lawful and respectful purposes only'),
                      _bullet('Not harass, abuse, impersonate, or harm other users'),
                      _bullet('Not upload illegal, explicit, or offensive content'),
                      _bullet(
                        'Not misuse the app or attempt to access it without authorization',
                      ),
                      _bodyText(
                        'We reserve the right to suspend or terminate accounts that violate these Terms.',
                      ),

                      _sectionTitle('User Content'),
                      _bullet(
                        'You are responsible for the content you post, including photos and messages.',
                      ),
                      _bullet(
                        'By posting content, you grant Love Cupid a non-exclusive right to use it for operating and promoting the app.',
                      ),

                      _sectionTitle('Safety'),
                      _bodyText(
                        'Love Cupid does not conduct full background checks. '
                        'Interact with others at your own risk and use caution when meeting in person.',
                      ),

                      _sectionTitle('Termination'),
                      _bodyText(
                        'You may delete your account at any time. We may terminate or suspend your access if you violate these Terms.',
                      ),

                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// SECTION TITLE
  Widget _sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 18.h, bottom: 6.h),
      child: Text(
        text,
        style: TextStyle(
          color: primaryPeach,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  /// BODY TEXT
  Widget _bodyText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          height: 1.6,
          color: textDark,
        ),
      ),
    );
  }

  /// BULLET ITEM
  Widget _bullet(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 6.w, bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: 16.sp,
              height: 1.5,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.6,
                color: textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
