import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bit_more_about_you_screen.dart'; // Ensure this file exists

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final TextEditingController _bioController = TextEditingController();
  
  // Store controllers for the dynamic prompt inputs
  final Map<String, TextEditingController> _promptControllers = {};
  
  // List of currently selected prompts
  final List<String> _selectedPrompts = [];

  final List<String> _availablePrompts = [
    'Two truths and a lie',
    'My ideal Sunday',
    'A fun fact about me',
    'I\'m looking for...',
    'My guilty pleasure',
    'Never have I ever...',
    'Key to my heart',
  ];

  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _bioController.dispose();
    // Dispose all dynamic controllers
    for (var controller in _promptControllers.values) {
      controller.dispose();
    }
    _overlayEntry?.remove();
    super.dispose();
  }

  /// Toggle logic for prompts with Limit of 3
  void _togglePrompt(String prompt) {
    setState(() {
      if (_selectedPrompts.contains(prompt)) {
        // Deselect: Remove from list and dispose controller
        _selectedPrompts.remove(prompt);
        _promptControllers[prompt]?.dispose();
        _promptControllers.remove(prompt);
      } else {
        // Select: Check limit first
        if (_selectedPrompts.length < 3) {
          _selectedPrompts.add(prompt);
          _promptControllers[prompt] = TextEditingController();
        } else {
          // Show Limit Reached Message
          _showTopMessage(context, 'You can only pick 3 prompts');
        }
      }
    });
  }

  void _showTopMessage(BuildContext context, String message) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20.w,
        right: 20.w,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFEC8E67),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, color: Colors.white, size: 20.sp),
                10.horizontalSpace,
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    Future.delayed(const Duration(seconds: 2), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,

              /// Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
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
                        Icons.arrow_back_ios_new_rounded,
                        size: 20.sp,
                        color: const Color(0xFFFF6A3D),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const BitMoreAboutYouScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: const Color(0xFFFF6A3D),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),

              30.verticalSpace,

              /// Title (Reduced size to fit one line)
              Text(
                'Tell us About Yourself',
                style: TextStyle(
                  fontSize: 24.sp, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              30.verticalSpace,

              /// Bio Label
              Text(
                'Bio',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              
              10.verticalSpace,
              
              /// Bio Input Field (Original Logic)
              Container(
                height: 120.h,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextField(
                  controller: _bioController,
                  maxLines: null,
                  maxLength: 500,
                  style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '', // Hides default counter
                    hintText: 'Write a short bio...',
                  ),
                ),
              ),
              
              /// Custom Counter Display
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: ValueListenableBuilder(
                    valueListenable: _bioController,
                    builder: (context, value, child) {
                      return Text(
                        '${value.text.length}/500',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                ),
              ),

              30.verticalSpace,

              /// --- Dynamic Prompt Inputs Section ---
              if (_selectedPrompts.isNotEmpty) ...[
                Text(
                  'Your Answers',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                10.verticalSpace,
                
                ..._selectedPrompts.map((prompt) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prompt,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFEC8E67),
                          ),
                        ),
                        8.verticalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F8F8),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: TextField(
                            controller: _promptControllers[prompt],
                            style: TextStyle(fontSize: 15.sp),
                            minLines: 1,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your answer here...',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                20.verticalSpace,
              ],

              /// Add Prompts Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Prompts',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${_selectedPrompts.length}/3', // Limit display
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              
              8.verticalSpace,
              
              Text(
                'Tap to add to your profile',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
              
              20.verticalSpace,

              /// Prompts Chips Grid
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: _availablePrompts.map((prompt) => _buildPromptChip(prompt)).toList(),
              ),

              40.verticalSpace,

              /// Confirm Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const BitMoreAboutYouScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEC8E67),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromptChip(String label) {
    final bool isSelected = _selectedPrompts.contains(label);

    return GestureDetector(
      onTap: () => _togglePrompt(label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          // Change color if selected
          color: isSelected ? const Color(0xFFEC8E67) : const Color(0xFFFFF1EA),
          borderRadius: BorderRadius.circular(16.r),
          // Add border if not selected (optional, effectively hiding it when selected)
          border: isSelected ? Border.all(color: Colors.transparent) : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            // Change text color if selected
            color: isSelected ? Colors.white : const Color(0xFFEC8E67),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}