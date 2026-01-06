import 'package:flutter/material.dart';

class FilterModalSheet extends StatefulWidget {
  const FilterModalSheet({super.key});

  @override
  State<FilterModalSheet> createState() => _FilterModalSheetState();
}

class _FilterModalSheetState extends State<FilterModalSheet> {
  // State variables to manage the UI inputs
  int _selectedGenderIndex = 0; // 0: Girls, 1: Boys, 2: Both
  double _distance = 40;
  RangeValues _ageRange = const RangeValues(20, 25);

  final Color _primaryColor = const Color(0xFFEC8E67); // The Orange color
  final Color _textDark = const Color(0xFF1F1F1F);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75, // Takes up 85% height
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          // 1. The Grey Handle Bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 2. Header: Filters & Clear
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40), // spacer to center the title roughly
              Text(
                "Filters",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _textDark,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Reset logic here
                },
                child: Text(
                  "Clear",
                  style: TextStyle(
                    color: _primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),

          // 3. Interested In Section
          _buildSectionTitle("Interested in"),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _buildGenderOption(0, "Girls"),
                Container(width: 1, height: 30, color: Colors.grey.shade200),
                _buildGenderOption(1, "Boys"),
                Container(width: 1, height: 30, color: Colors.grey.shade200),
                _buildGenderOption(2, "Both"),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 4. Location Section
          Text(
            "Location",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Chicago, USA",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: _textDark,
                  ),
                ),
                Icon(Icons.chevron_right, color: _primaryColor),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 5. Distance Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle("Distance"),
              Text(
                "${_distance.toInt()}km",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              activeTrackColor: _primaryColor,
              inactiveTrackColor: Colors.grey.shade200,
              thumbColor: _primaryColor,
              overlayColor: _primaryColor.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            ),
            child: Slider(
              value: _distance,
              min: 0,
              max: 100,
              onChanged: (val) => setState(() => _distance = val),
            ),
          ),

          const SizedBox(height: 20),

          // 6. Age Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionTitle("Age"),
              Text(
                "${_ageRange.start.toInt()}-${_ageRange.end.toInt()}",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 2,
              activeTrackColor: _primaryColor,
              inactiveTrackColor: Colors.grey.shade200,
              thumbColor: _primaryColor,
              overlayColor: _primaryColor.withOpacity(0.2),
              rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 12),
            ),
            child: RangeSlider(
              values: _ageRange,
              min: 18,
              max: 60,
              onChanged: (val) => setState(() => _ageRange = val),
            ),
          ),

          const Spacer(),

          // 7. Continue Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: _textDark,
      ),
    );
  }

  // Custom widget for the Gender Selector to match the image exactly
  Widget _buildGenderOption(int index, String text) {
    final isSelected = _selectedGenderIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGenderIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? _primaryColor : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: index == 0 ? const Radius.circular(15) : Radius.zero,
              bottomLeft: index == 0 ? const Radius.circular(15) : Radius.zero,
              topRight: index == 2 ? const Radius.circular(15) : Radius.zero,
              bottomRight: index == 2 ? const Radius.circular(15) : Radius.zero,
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}