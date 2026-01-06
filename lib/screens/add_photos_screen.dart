import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'gender_selection_screen.dart'; // Ensure this file exists

class AddPhotosScreen extends StatefulWidget {
  const AddPhotosScreen({super.key});

  @override
  State<AddPhotosScreen> createState() => _AddPhotosScreenState();
}

class _AddPhotosScreenState extends State<AddPhotosScreen> {
  // Store up to 4 images
  final List<File?> _images =List.generate(4, (index) => null);
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(int index, ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _images[index] = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  // Find the first empty slot to upload to
  void _uploadToNextSlot(ImageSource source) {
    int nextIndex = _images.indexWhere((element) => element == null);
    if (nextIndex != -1) {
      _pickImage(nextIndex, source);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All slots are full! Tap an image to remove it.")),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images[index] = null;
    });
  }

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
              10.verticalSpace,

              /// Skip Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const GenderSelectionScreen(),
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
              Text(
                "Add Photos",
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              8.verticalSpace,

              /// Subtitle
              Text(
                'Make Sure You Upload a Picture With Good\nLighting to Make Your Profile Stand Out.',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),

              30.verticalSpace,

              /// Photo Grid
              GridView.builder(
                shrinkWrap: true,
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 1,
                ),
                itemBuilder: (_, index) {
                  return _photoSlot(index);
                },
              ),

              30.verticalSpace,

              /// Upload / Take Photo Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _actionChip(
                    text: 'Upload', 
                    onTap: () => _uploadToNextSlot(ImageSource.gallery),
                  ),
                  20.horizontalSpace,
                  _actionChip(
                    text: 'Take Photo', 
                    onTap: () => _uploadToNextSlot(ImageSource.camera),
                  ),
                ],
              ),

              const Spacer(),

              /// Confirm Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const GenderSelectionScreen(),
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

              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  /// Individual Photo Slot Widget
  Widget _photoSlot(int index) {
    final imageFile = _images[index];

    return GestureDetector(
      onTap: () {
        if (imageFile == null) {
          _pickImage(index, ImageSource.gallery);
        }
      },
      child: imageFile != null
          ? Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _removeImage(index),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : CustomPaint(
              painter: DashedBorderPainter(
                color: Colors.grey.shade400,
                strokeWidth: 1.5,
                dashPattern: [6, 4],
                radius: Radius.circular(20.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8), // Very light grey fill
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 32.sp,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
    );
  }

  /// Upload / Take photo chip
  Widget _actionChip({required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFDF0E9), // Light peach
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: const Color(0xFFEC8E67), // Orange text
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

/// 🎨 Custom Painter for Dashed Border
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final Radius radius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1,
    this.dashPattern = const [5, 3],
    this.radius = const Radius.circular(0),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          radius,
        ),
      );

    final Path dashedPath = _createDashedPath(path);
    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0;
      int index = 0;
      while (distance < metric.length) {
        final double len = dashPattern[index % dashPattern.length];
        if (index % 2 == 0) {
          dest.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        index++;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashPattern != dashPattern ||
        oldDelegate.radius != radius;
  }
}