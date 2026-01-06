import 'dart:io'; // Required for File
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart'; // Required for picking photos
import 'add_photos_screen.dart'; 
import '../widgets/birthday_picker_sheet.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  DateTime? _selectedDate;
  File? _profileImage; // Variable to store the picked image
  final ImagePicker _picker = ImagePicker();

  // Simple formatter for the date display
  String get _formattedDate {
    if (_selectedDate == null) return 'Choose birthday date';
    // Format: DD/MM/YYYY
    return "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}";
  }

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      // SafeArea ensures we don't draw behind the status bar or bottom nav bar
      body: SafeArea(
        child: Column(
          children: [
            // 1. SCROLLABLE CONTENT (Takes up all remaining space)
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,

                    /// Header: Skip Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AddPhotosScreen(),
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
                    ),

                    /// Title
                    Padding(
                      padding: EdgeInsets.only(left: 20.w), 
                      child: Text(
                        'Profile details',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                    ),

                    40.verticalSpace,

                    /// Profile Image Picker
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage, 
                        child: Stack(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200,
                                image: DecorationImage(
                                  image: _profileImage != null
                                      ? FileImage(_profileImage!) as ImageProvider
                                      : const AssetImage('assets/images/photo.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 36.w,
                                height: 36.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF6A3D).withOpacity(0.9),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    size: 18.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    50.verticalSpace,

                    /// First name
                    _inputField(label: 'First name', hint: 'David'),

                    20.verticalSpace,

                    /// Last name
                    _inputField(label: 'Last name', hint: 'Peterson'),

                    20.verticalSpace,

                    /// Birthday Picker Button
                    GestureDetector(
                      onTap: () async {
                        final result = await showModalBottomSheet<DateTime>(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => BirthdayPickerSheet(
                            initialDate: _selectedDate ?? DateTime(1995, 7, 11),
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            _selectedDate = result;
                          });
                        }
                      },
                      child: Container(
                        height: 58.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF0E9), // Light peach bg
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: const Color(0xFFEC8E67), // Orange icon
                              size: 24.sp,
                            ),
                            14.horizontalSpace,
                            Text(
                              _formattedDate,
                              style: TextStyle(
                                color: const Color(0xFFEC8E67), // Orange text
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // We removed the huge spacer and button from here
                    // to prevent them from scrolling off-screen.
                    20.verticalSpace, 
                  ],
                ),
              ),
            ),

            // 2. FIXED BOTTOM BUTTON
            // This stays pinned to the bottom of the SafeArea
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AddPhotosScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEC8E67), // Orange
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
            ),
          ],
        ),
      ),
    );
  }

  /// Helper widget for input fields
  Widget _inputField({required String label, required String hint}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8), 
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.transparent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          6.verticalSpace,
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 30.h,
            child: TextField(
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 12.h),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}