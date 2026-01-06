import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateFilterModalSheet extends StatefulWidget {
  const DateFilterModalSheet({super.key});

  @override
  State<DateFilterModalSheet> createState() => _DateFilterModalSheetState();
}

class _DateFilterModalSheetState extends State<DateFilterModalSheet> {
  // Default selected option based on the image
  String _selectedOption = 'Today';

  final List<String> _options = [
    'This week',
    'Maximum',
    'Today',
    'Yesterday',
    'Today and Yesterday',
    'Last 7 days',
    'Last 14 days',
    'Last 28 days',
  ];

  final Color _primaryColor = const Color(0xFFEC8E67);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Adjust height as needed (e.g., 60-70% of screen)
      height: MediaQuery.of(context).size.height * 0.60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        children: [
          // Grey Handle Bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          SizedBox(height: 30.h),

          // Radio List
          Expanded(
            child: ListView.separated(
              itemCount: _options.length,
              separatorBuilder: (_, __) => SizedBox(height: 20.h),
              itemBuilder: (context, index) {
                final option = _options[index];
                final isSelected = option == _selectedOption;

                return GestureDetector(
                  onTap: () => setState(() => _selectedOption = option),
                  // Transparent container to make the whole row clickable
                  child: Container(
                    color: Colors.transparent, 
                    child: Row(
                      children: [
                        // Custom Radio Button
                        Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? _primaryColor : Colors.grey.shade300,
                              width: isSelected ? 7.w : 1.w, // Thick border creates the "dot" effect
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        // Text
                        Text(
                          option,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'SF Pro Display', // Use your app's font
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Continue Button
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () {
                // Return the selected value when closing
                Navigator.pop(context, _selectedOption);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}