import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'discover_screen.dart'; // Your existing swiper screen
import 'likes_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DiscoverScreen(), // Index 0: Cards/Swipe
    const LikesScreen(),    // Index 1
    const ChatScreen(),     // Index 2
    const ProfileScreen(),  // Index 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack preserves the state of the swiper when switching tabs
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}