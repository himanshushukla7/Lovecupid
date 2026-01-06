import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BirthdayPickerSheet extends StatefulWidget {
  final DateTime initialDate;

  const BirthdayPickerSheet({super.key, required this.initialDate});

  @override
  State<BirthdayPickerSheet> createState() => _BirthdayPickerSheetState();
}

class _BirthdayPickerSheetState extends State<BirthdayPickerSheet> {
  late DateTime _currentMonth; 
  late DateTime _selectedDay; 
  
  // Toggle between Calendar Grid and Year Wheel
  bool _isYearSelectionMode = false; 

  final List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDate;
    _currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month, 1);
  }

  void _changeMonth(int offset) {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + offset, 1);
    });
  }

  void _changeYear(int year) {
    setState(() {
      _currentMonth = DateTime(year, _currentMonth.month, 1);
      _isYearSelectionMode = false; // Close picker after selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 560.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFD), 
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          12.verticalSpace,
          // Drag Handle
          Container(
            width: 48.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          
          20.verticalSpace,
          
          // Title
          Text(
            "Birthday",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          
          15.verticalSpace,

          // --- HEADER CONTROLS ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Arrow (Hide in Year Mode)
                Opacity(
                  opacity: _isYearSelectionMode ? 0.0 : 1.0,
                  child: IconButton(
                    onPressed: _isYearSelectionMode ? null : () => _changeMonth(-1),
                    icon: Icon(Icons.chevron_left_rounded, size: 32.sp, color: Colors.black54),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
                
                // CENTER: Year & Month Display
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isYearSelectionMode = !_isYearSelectionMode;
                    });
                  },
                  child: Column(
                    children: [
                      // YEAR (Clickable)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${_currentMonth.year}",
                            style: TextStyle(
                              fontSize: 34.sp,
                              fontWeight: FontWeight.w800,
                              // Dim color slightly if mode is open to indicate interaction
                              color: const Color(0xFFEC8E67), 
                              height: 1.0,
                              shadows: [
                                BoxShadow(
                                   color: const Color(0xFFEC8E67).withOpacity(0.25),
                                   blurRadius: 12,
                                   offset: const Offset(0, 4)
                                )
                              ]
                            ),
                          ),
                          if (_isYearSelectionMode) 
                             Icon(Icons.arrow_drop_up_rounded, color: const Color(0xFFEC8E67), size: 24.sp)
                          else
                             Icon(Icons.arrow_drop_down_rounded, color: const Color(0xFFEC8E67).withOpacity(0.5), size: 24.sp)
                        ],
                      ),
                      6.verticalSpace,
                      // MONTH
                      Text(
                        _months[_currentMonth.month - 1],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFEC8E67),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Right Arrow (Hide in Year Mode)
                Opacity(
                  opacity: _isYearSelectionMode ? 0.0 : 1.0,
                  child: IconButton(
                    onPressed: _isYearSelectionMode ? null : () => _changeMonth(1),
                    icon: Icon(Icons.chevron_right_rounded, size: 32.sp, color: Colors.black54),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
          ),

          20.verticalSpace,

          // --- CONDITIONAL BODY ---
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isYearSelectionMode 
                  ? _buildYearPicker() // 1. Smooth Year Wheel
                  : Column(            // 2. Calendar Grid
                      key: const ValueKey('Calendar'),
                      children: [
                        // Weekday Headers
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: _weekDays.map((day) => SizedBox(
                              width: 40.w,
                              child: Center(
                                child: Text(
                                  day,
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )).toList(),
                          ),
                        ),
                        10.verticalSpace,
                        // Swipeable Grid
                        Expanded(
                          child: GestureDetector(
                            onHorizontalDragEnd: (details) {
                              // Swipe Logic for Months
                              if (details.primaryVelocity! > 0) {
                                _changeMonth(-1); // Swipe Right -> Prev Month
                              } else if (details.primaryVelocity! < 0) {
                                _changeMonth(1); // Swipe Left -> Next Month
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: _buildCalendarGrid(),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          // Save Button
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 30.h),
            child: SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _selectedDay);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEC8E67), // Orange
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET: SMOOTH YEAR WHEEL ---
  Widget _buildYearPicker() {
    final currentYear = DateTime.now().year;
    final startYear = 1900;
    // Calculate initial scroll offset to center the current selected year
    final initialItem = _currentMonth.year - startYear;

    return ListWheelScrollView.useDelegate(
      key: const ValueKey('YearPicker'),
      controller: FixedExtentScrollController(initialItem: initialItem),
      itemExtent: 50.h,
      perspective: 0.005,
      diameterRatio: 1.2,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) {
        // Optional: Update background year instantly while scrolling? 
        // Or just wait for tap. Let's just wait for tap to confirm.
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: currentYear - startYear + 1, // Range 1900 to Now
        builder: (context, index) {
          final year = startYear + index;
          final isSelected = year == _currentMonth.year;

          return GestureDetector(
            onTap: () => _changeYear(year),
            child: Center(
              child: Text(
                "$year",
                style: TextStyle(
                  fontSize: isSelected ? 26.sp : 20.sp,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                  color: isSelected ? const Color(0xFFEC8E67) : Colors.grey.shade400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- WIDGET: CALENDAR GRID ---
  Widget _buildCalendarGrid() {
    final daysInMonth = DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month);
    final firstDayOfWeek = DateTime(_currentMonth.year, _currentMonth.month, 1).weekday;
    
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: daysInMonth + firstDayOfWeek - 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 6.w,
      ),
      itemBuilder: (context, index) {
        if (index < firstDayOfWeek - 1) return const SizedBox();

        final day = index - (firstDayOfWeek - 1) + 1;
        final date = DateTime(_currentMonth.year, _currentMonth.month, day);
        
        final isSelected = date.year == _selectedDay.year && 
                           date.month == _selectedDay.month && 
                           date.day == _selectedDay.day;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDay = date;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFEC8E67) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF4A4A4A),
                  fontSize: 15.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}