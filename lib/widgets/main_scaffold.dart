import 'package:flutter/material.dart';
import 'profile_slide_menu.dart';
import 'bottom_nav_bar.dart';
import '../controller/navigation_controller.dart';

class MainScaffold extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  const MainScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
  });

  @override
  State<MainScaffold> createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void toggleMenu() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.body,

          // Dark overlay
          if (_controller.value > 0)
            GestureDetector(
              onTap: toggleMenu,
              child: Container(
                color: Colors.black.withOpacity(0.25),
              ),
            ),

          // Slide menu
          ProfileSlideMenu(
            animation: _controller,
            onClose: toggleMenu,
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: widget.currentIndex,
        onTap: (context, index) {
          if (index == widget.currentIndex && index == 3) {
            toggleMenu();
          } else {
            NavigationController.navigateTo(
              context,
              index,
              widget.currentIndex,
            );
          }
        },
      ),
    );
  }
}
