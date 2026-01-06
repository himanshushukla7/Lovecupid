import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/bottom_nav_bar.dart';
import '../controller/navigation_controller.dart';
import 'chat_detail_screen.dart'; // Import the new screen

class ChatScreen extends StatelessWidget {
  final int? forcedIndex;
  const ChatScreen({super.key, this.forcedIndex});

  final int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              // 1. Large Title
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 34.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SF Pro Display',
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // 2. Search Bar
           Container(
  height: 48.h,
  decoration: BoxDecoration(
    color: const Color(0xFFF4F7F5),
    borderRadius: BorderRadius.circular(15.r),
    border: Border.all(color: const Color(0xFFE8E6EA)),
  ),
  child: TextField(
    textAlignVertical: TextAlignVertical.center,
    decoration: InputDecoration(
      hintText: 'Search',
      hintStyle: TextStyle(
        color: Colors.black.withOpacity(0.4),
        fontSize: 14.sp,
        fontFamily: 'SF Pro Display',
      ),
      // 🔥 Updated to use your asset image
      prefixIcon: Padding(
        padding: EdgeInsets.all(12.w), // Padding centers the image (48h - 24w) / 2 = 12
        child: Image.asset(
          'assets/icons/search.png',
          width: 24.w,
          height: 24.w,
          // Remove 'color' line below if your PNG has its own colors you want to keep
          color: Colors.black.withOpacity(0.4), 
        ),
      ),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      isDense: true,
    ),
  ),
),

              SizedBox(height: 25.h),

              // 3. Sub-header
              Text(
                'Messages',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SF Pro Display',
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 10.h),

              // 4. Chat List
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 20.h),
                  itemCount: 6,
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(left: 85.w, right: 8.w),
                    child: Divider(
                      color: const Color(0xFFE8E6EA),
                      height: 1.h,
                      thickness: 1.h,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    final chatData = _getChatData(index);
                    return _buildChatTile(
                      context: context,
                      name: chatData['name'],
                      message: chatData['message'],
                      time: chatData['time'],
                      image: chatData['image'],
                      unreadCount: chatData['unreadCount'],
                      hasStory: chatData['hasStory'],
                      isTyping: chatData['isTyping'],
                      isRead: chatData['isRead'],
                      isMe: chatData['isMe'] ?? false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: forcedIndex ?? 2,
        onTap: (context, index) => NavigationController.navigateTo(context, index, _currentIndex),
      ),
    );
  }

  Map<String, dynamic> _getChatData(int index) {
    switch (index) {
      case 0:
        return {
          'name': "Emelie",
          'message': "Sticker 😍",
          'time': "23 min",
          'image': "assets/images/p1.png",
          'unreadCount': 1,
          'hasStory': false,
          'isTyping': false,
          'isRead': false,
        };
      case 1:
        return {
          'name': "Abigail",
          'message': "Typing..",
          'time': "27 min",
          'image': "assets/images/p2.png",
          'unreadCount': 2,
          'hasStory': false,
          'isTyping': true,
          'isRead': false,
        };
      case 2:
        return {
          'name': "Elizabeth",
          'message': "Ok, see you then.",
          'time': "33 min",
          'image': "assets/images/p5.jpg",
          'unreadCount': 0,
          'hasStory': false,
          'isTyping': false,
          'isRead': false,
        };
      case 3:
        return {
          'name': "Penelope",
          'message': "Hey! What's up, long time..",
          'time': "50 min",
          'image': "assets/images/p4.png",
          'unreadCount': 0,
          'hasStory': false,
          'isTyping': false,
          'isRead': true,
          'isMe': true, 
        };
      case 4:
        return {
          'name': "Chloe",
          'message': "Hello how are you?",
          'time': "55 min",
          'image': "assets/images/c1.jpg",
          'unreadCount': 0,
          'hasStory': false,
          'isTyping': false,
          'isRead': true,
          'isMe': true,
        };
      case 5:
        return {
          'name': "Grace",
          'message': "Great I will write later..",
          'time': "1 hour",
          'image': "assets/images/p2.png",
          'unreadCount': 0,
          'hasStory': false,
          'isTyping': false,
          'isRead': true,
          'isMe': true,
        };
      default:
        return {};
    }
  }

  Widget _buildChatTile({
    required BuildContext context,
    required String name,
    required String message,
    required String time,
    required String image,
    int unreadCount = 0,
    bool hasStory = false,
    bool isTyping = false,
    bool isRead = false,
    bool isMe = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(name: name, image: image),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Avatar Section ---
            Container(
              width: 60.w,
              height: 60.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (hasStory)
                    Container(
                      width: 58.w,
                      height: 58.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFEC8E67),
                          width: 2.0,
                        ),
                      ),
                    ),
                  
                  Hero( // Wrap avatar in Hero for shared element transition
                    tag: 'avatar_$name',
                    child: Container(
                      width: hasStory ? 50.w : 58.w,
                      height: hasStory ? 50.w : 58.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: hasStory 
                            ? Border.all(color: Colors.white, width: 2) 
                            : null,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 14.w),

            // --- Name & Message ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF Pro Display',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  
                  if (isTyping)
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF Pro Display',
                        color: const Color(0xFFEC8E67),
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  else
                    Text.rich(
                      TextSpan(
                        children: [
                          if (isMe)
                            TextSpan(
                              text: "You: ",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          TextSpan(
                            text: message,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                ],
              ),
            ),

            // --- Time & Badge ---
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SF Pro Display',
                    color: const Color(0xFFADAFBB),
                  ),
                ),
                SizedBox(height: 4.h),
                if (unreadCount > 0)
                  Container(
                    width: 20.w,
                    height: 20.w,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEC8E67),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                  )
                else
                  SizedBox(height: 20.w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}