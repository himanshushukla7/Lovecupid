import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'full_details_screen.dart'; 
import '../widgets/chat_options_bottom_sheet.dart';
import '../widgets/action_success_dialog.dart';
import '../widgets/help_support_popup.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String image;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  bool _isTyping = false;

  // Store messages in a list so we can add to them
  final List<Map<String, dynamic>> _messages = [
    {
      "isSender": false,
      "message": "Hi Jake, how are you? I saw on the app that we've crossed paths several times this week 😄",
      "time": "2:55 PM"
    },
    {
      "isSender": true,
      "message": "Haha truly! Nice to meet you Grace! What about a cup of coffee today evening? ☕️",
      "time": "3:02 PM",
      "isRead": true
    },
    {
      "isSender": false,
      "message": "Sure, let's do it! 😋",
      "time": "3:10 PM"
    },
    {
      "isSender": true,
      "message": "Great I will write later the exact time and place. See you soon!",
      "time": "3:12 PM",
      "isRead": true
    },
  ];

  @override
  void initState() {
    super.initState();
    // Listen to text changes to toggle the icon
    _textController.addListener(() {
      setState(() {
        _isTyping = _textController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;

    final String text = _textController.text.trim();
    
    // Get current time (Simple formatting for demo)
    final now = TimeOfDay.now();
    final String timeString = "${now.hourOfPeriod}:${now.minute.toString().padLeft(2, '0')} ${now.period == DayPeriod.am ? 'AM' : 'PM'}";

    setState(() {
      _messages.add({
        "isSender": true,
        "message": text,
        "time": timeString,
        "isRead": false, // New messages are unread by default in UI logic
      });
      _textController.clear();
      _isTyping = false;
    });

    // Scroll to bottom after frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70.h,
        leadingWidth: 80.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Icon(
                  Icons.chevron_left_rounded,
                  color: const Color(0xFFEC8E67),
                  size: 28.sp,
                ),
              ),
            ),
          ),
        ),
        titleSpacing: 10.w,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullDetailsScreen(
                    name: widget.name, image: widget.image),
              ),
            );
          },
          child: Row(
            children: [
              // 🔥 UPDATED: Removed the Container with the border
              CircleAvatar(
                radius: 22.r, // Slightly increased radius to maintain size
                backgroundImage: AssetImage(widget.image),
                backgroundColor: Colors.grey.shade200, // Fallback color
              ),
              
              SizedBox(width: 10.w),
              
              // Name and Status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF Pro Display',
                      fontSize: 18.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEC8E67),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "Online",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          // ... (Rest of your actions code remains the same)
          GestureDetector(
            onTap: () {
              showChatOptionsBottomSheet(
                context: context,
                onReport: () {
                  showActionSuccessDialog(
                    context: context,
                    title: "Reported",
                    message: "Thank you for your feedback...",
                  );
                },
                onUnmatch: () {
                  showActionSuccessDialog(
                    context: context,
                    title: "Unmatched",
                    message: "You have successfully unmatched...",
                    icon: Icons.close,
                    iconColor: Colors.deepOrange,
                  );
                },
                onServiceCentre: () {
                 showDialog(
  context: context,
  barrierDismissible: true,
  builder: (_) => const HelpSupportPopup(),
);
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 20.w),
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Icon(
                Icons.more_vert_rounded,
                color: Colors.black,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
      // ... (Rest of body code remains the same)
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      _buildDateSeparator("Today"),
                      SizedBox(height: 20.h),
                    ],
                  );
                }
                final messageData = _messages[index - 1];
                if (messageData['isSender']) {
                  return _buildSenderMessage(
                    messageData['message'],
                    messageData['time'],
                    isRead: messageData['isRead'] ?? false,
                  );
                } else {
                  return _buildReceiverMessage(
                    messageData['message'],
                    messageData['time'],
                  );
                }
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildDateSeparator(String text) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.sp,
              fontFamily: 'SF Pro Display',
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300)),
      ],
    );
  }

  Widget _buildReceiverMessage(String message, String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            constraints: BoxConstraints(maxWidth: 0.75.sw),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F7F5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
                bottomLeft: Radius.zero,
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                fontFamily: 'SF Pro Display',
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11.sp,
              fontFamily: 'SF Pro Display',
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSenderMessage(String message, String time, {bool isRead = false}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            constraints: BoxConstraints(maxWidth: 0.75.sw),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
                bottomRight: Radius.zero,
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                fontFamily: 'SF Pro Display',
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11.sp,
                  fontFamily: 'SF Pro Display',
                ),
              ),
              SizedBox(width: 4.w),
              if (isRead)
                Icon(Icons.done_all, color: const Color(0xFFEC8E67), size: 16.sp),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      color: Colors.white,
      child: Row(
        children: [
          // Text Input
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      // Note: Listener in initState handles state updates
                      decoration: InputDecoration(
                        hintText: "Your message",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14.sp,
                          fontFamily: 'SF Pro Display',
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.sticky_note_2_outlined,
                      color: Colors.grey.shade400),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          
          // Send / Mic Button
          GestureDetector(
            onTap: () {
              if (_isTyping) {
                _sendMessage();
              } else {
                // Mic logic here
                debugPrint("Mic Tapped");
              }
            },
            child: Container(
              width: 50.h,
              height: 50.h,
              decoration: BoxDecoration(
                // Change background color to orange if typing to make send button obvious
                color: _isTyping ? const Color(0xFFEC8E67) : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: _isTyping ? const Color(0xFFEC8E67) : Colors.grey.shade200,
                ),
              ),
              child: Icon(
                // Toggle Icon
                _isTyping ? Icons.send_rounded : Icons.mic,
                // Toggle Color
                color: _isTyping ? Colors.white : const Color(0xFFEC8E67),
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}