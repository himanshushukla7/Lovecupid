import 'package:flutter/material.dart';
import '../screens/discover_screen.dart';
import '../screens/likes_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/profile_screen.dart';

class NavigationController {
  static void navigateTo(BuildContext context, int targetIndex, int currentIndex) {
    if (targetIndex == currentIndex) return;

    Widget targetScreen;

    if (targetIndex == 3) {
      // 🟢 GOING TO PROFILE
      Widget currentScreenWidget;

      // 🔥 HERE IS THE FIX:
      // We recreate the current screen but force its BottomNav to show Index 3 (Profile)
      switch (currentIndex) {
        case 0:
          currentScreenWidget = const DiscoverScreen(forcedIndex: 3);
          break;
        case 1:
          currentScreenWidget = LikesScreen(forcedIndex: 3);
          break;
        case 2:
          currentScreenWidget = const ChatScreen(forcedIndex: 3);
          break;
        default:
          currentScreenWidget = const DiscoverScreen(forcedIndex: 3);
      }

      targetScreen = ProfileScreen(
        contentScreen: currentScreenWidget,
        previousIndex: currentIndex,
      );

    } else {
      // 🔵 GOING TO OTHER TABS (Normal behavior)
      switch (targetIndex) {
        case 0:
          targetScreen = const DiscoverScreen();
          break;
        case 1:
          targetScreen = LikesScreen();
          break;
        case 2:
          targetScreen = const ChatScreen();
          break;
        default:
          return;
      }
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => targetScreen,
        transitionDuration: Duration.zero,
      ),
    );
  }
}