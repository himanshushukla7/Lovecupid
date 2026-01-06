import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_screen.dart';
import 'discover_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<double> _titleOpacity;
  late Animation<double> _taglineOpacity;
  late Animation<double> _ornamentRotation;

  /// 🔥 CARD SLIDE ANIMATIONS
  late Animation<double> _leftCardX;
  late Animation<double> _rightCardX;

  bool _showButton = false;
  bool _navigated = false;

  /// 🖐️ SLIDER STATE
  double _dragPosition = 0.0;
  final double _buttonWidth = 241;
  final double _arrowWidth = 48;
  final double _padding = 6;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..forward();

    /// LOGO
    _logoScale = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );

    _logoRotation = Tween(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4)),
    );

    /// TEXT FADE
    _titleOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.65)),
    );

    _taglineOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.55, 0.8)),
    );

    /// ORNAMENT ROTATION
    _ornamentRotation = Tween(begin: 0.0, end: pi * 2).animate(_controller);

    /// 🧊 CARD SLIDES
    _leftCardX = Tween<double>(
      begin: -300.w,
      end: -90.w,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _rightCardX = Tween<double>(
      begin: 1.0.sw + 20.w,
      end: 1.0.sw - 190.w,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _showButton = true);
      }
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    // Calculate max slide distance (Total width - Padding - Arrow width)
    final double maxDrag = _buttonWidth.w - (_padding.w * 2) - _arrowWidth.w;

    setState(() {
      // 🔥 LEFT TO RIGHT LOGIC:
      // We ADD dx because moving right creates positive values.
      _dragPosition += details.delta.dx;

      // Clamp to ensure it doesn't go outside the bounds
      if (_dragPosition < 0) _dragPosition = 0;
      if (_dragPosition > maxDrag) _dragPosition = maxDrag;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    final double maxDrag = _buttonWidth.w - (_padding.w * 2) - _arrowWidth.w;
    // If dragged more than 70% to the RIGHT, trigger navigation
    if (_dragPosition > maxDrag * 0.7) {
      // Snap to end (Right side)
      setState(() {
        _dragPosition = maxDrag;
      });
      _navigateNext();
    } else {
      // Snap back to start (Left side)
      setState(() {
        _dragPosition = 0.0;
      });
    }
  }

  void _navigateNext() {
    if (_navigated) return;
    _navigated = true;

    // Small delay to let the slide finish visually
    Future.delayed(const Duration(milliseconds: 200), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
         // MaterialPageRoute(builder: (_) => const DiscoverScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = 280.w;
    final double cardHeight = 460.h;
    
    // 🔥 GET BOTTOM PADDING (For 3-button navigation / Home bar)
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          /// 🌈 GRADIENT BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFF9A6C), Color(0xFFFF6A3D)],
              ),
            ),
          ),

          /// 🔵 ORNAMENTS
          _buildOrnament(top: -60.h, left: -60.w, size: 220.w),
          _buildOrnament(bottom: -80.h, right: -80.w, size: 260.w),

          /// 🖼️ RIGHT SLIDING IMAGE CARD
          AnimatedBuilder(
            animation: _rightCardX,
            builder: (_, __) => Positioned(
              top: 0.14.sh,
              left: _rightCardX.value,
              child: _imageCard(
                width: cardWidth,
                height: cardHeight,
                rotateDeg: -12,
                imagePath: 'assets/images/Group 945.png',
              ),
            ),
          ),

          /// 🖼️ LEFT SLIDING IMAGE CARD
          AnimatedBuilder(
            animation: _leftCardX,
            builder: (_, __) => Positioned(
              top: 0.42.sh,
              left: _leftCardX.value,
              child: _imageCard(
                width: cardWidth,
                height: cardHeight,
                rotateDeg: 12,
                imagePath: 'assets/images/Group 944.png',
              ),
            ),
          ),

          /// 🎯 CENTER CONTENT
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) => Transform.rotate(
                    angle: _logoRotation.value,
                    child: ScaleTransition(scale: _logoScale, child: child),
                  ),
                  child: Image.asset(
                    'assets/images/lovecupid_logo.png',
                    width: 110.w,
                    height: 110.h,
                  ),
                ),
                20.verticalSpace,
                FadeTransition(
                  opacity: _titleOpacity,
                  child: Text(
                    'LoveCupid',
                    style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                12.verticalSpace,
                FadeTransition(
                  opacity: _taglineOpacity,
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFF9F77FF),
                        Color(0xFFFFEC84),
                        Color(0xFFFF23FF),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'Swipe Right,\nMatch vibe!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 🚀 SLIDER BUTTON
          if (_showButton)
            Positioned(
              // 🔥 UPDATED: Adds safe area padding so 3-button nav doesn't hide it
              bottom: 40.h + bottomPadding, 
              left: 0,
              right: 0,
              child: Center(
                child: _buildSliderButton(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOrnament(
      {double? top,
      double? left,
      double? right,
      double? bottom,
      required double size}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: AnimatedBuilder(
        animation: _ornamentRotation,
        builder: (_, __) => Transform.rotate(
          angle: _ornamentRotation.value,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.06),
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageCard({
    required double width,
    required double height,
    required double rotateDeg,
    required String imagePath,
  }) {
    return Transform.rotate(
      angle: rotateDeg * pi / 180,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28.r),
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  /// 🔥 SLIDER BUTTON LOGIC
  Widget _buildSliderButton() {
    // Calculate slider width dynamically or use fixed
    final double totalWidth = _buttonWidth.w;
    final double arrowWidth = _arrowWidth.w;
    final double padding = _padding.w;
    final double maxDrag = totalWidth - (padding * 2) - arrowWidth;

    // Opacity calculation for text based on drag
    double textOpacity = 1.0 - (_dragPosition / maxDrag);
    if (textOpacity < 0) textOpacity = 0;

    return Container(
      width: totalWidth,
      height: 58.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x26000000),
            blurRadius: 42,
            offset: const Offset(2, 12),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          /// 1. Centered Text (Fades out)
          Center(
            child: Opacity(
              opacity: textOpacity,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.w), // 🔥 Offset to RIGHT (since arrow is on LEFT)
                child: Text(
                  'Start Matching',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          /// 2. Sliding Arrow (Starts on LEFT, Slides RIGHT)
          Positioned(
            left: padding + _dragPosition, // 🔥 Anchored to LEFT now
            top: padding,
            bottom: padding,
            child: GestureDetector(
              onHorizontalDragUpdate: _handleDragUpdate,
              onHorizontalDragEnd: _handleDragEnd,
              child: Container(
                width: arrowWidth,
                height: 48.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6A3D).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.arrow_forward, // Keeps arrow pointing right as per design
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}