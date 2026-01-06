import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import your existing screens
import 'discover_screen.dart';
import 'likes_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart'; // This is the menu we just updated in Step 1
import '../widgets/bottom_nav_bar.dart'; // Keep your existing nav bar

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  // This index controls the content (0: Discover, 1: Likes, 2: Chat)
  int _currentIndex = 0; 
  bool _isDrawerOpen = false;

  // List of your actual content screens
  final List<Widget> _screens = [
    const DiscoverScreen(),
    LikesScreen(),
    const ChatScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Animation 1: Shrink the screen to 85% size
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Animation 2: Slide screen to the LEFT (-220 pixels)
    _slideAnimation = Tween<double>(begin: 0.0, end: -220.w).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // LOGIC: Toggle the drawer open/close
  void _toggleDrawer() {
    if (_isDrawerOpen) {
      _animationController.reverse(); // Close it
    } else {
      _animationController.forward(); // Open it
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  // LOGIC: Handle Bottom Nav Taps locally (No NavigationController needed here)
  void _onBottomNavTap(int index) {
    if (index == 3) {
      // If user clicks "Profile", toggle the animation
      _toggleDrawer();
    } else {
      // If user clicks Discover, Likes, or Chat
      setState(() {
        _currentIndex = index;
      });
      
      // If the drawer was open, close it automatically
      if (_isDrawerOpen) {
        _toggleDrawer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE98D6B), // Same color as ProfileScreen
      body: Stack(
        children: [
          // LAYER 1: The Profile Menu (Always at the back)
          const ProfileScreen(),

          // LAYER 2: The Content (Discover/Likes/Chat)
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.centerRight, // Pivot from the right side
                transform: Matrix4.identity()
                  ..translate(_slideAnimation.value) // Move Left
                  ..scale(_scaleAnimation.value),    // Shrink
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_isDrawerOpen ? 30.r : 0),
                  child: Scaffold(
                    // Show the selected screen (Discover, Likes, or Chat)
                    body: _screens[_currentIndex], 
                    
                    // We put the BottomNavBar HERE so it moves with the screen
                    bottomNavigationBar: CustomBottomNavBar(
                      currentIndex: _isDrawerOpen ? 3 : _currentIndex,
                      onTap: (context, index) => _onBottomNavTap(index),
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
}