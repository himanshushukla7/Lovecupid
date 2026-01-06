import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/splash_screen.dart'; // Ensure this import path is correct

void main() {
  runApp(const LoveCupidApp());
}

class LoveCupidApp extends StatelessWidget {
  const LoveCupidApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Standard iPhone Design Size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LoveCupid',
          theme: ThemeData(
            primarySwatch: Colors.orange,
            scaffoldBackgroundColor: const Color(0xFFFDFDFD), // Global background color
            fontFamily: 'SF Pro Display', // 🔥 Updated Font Family
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}