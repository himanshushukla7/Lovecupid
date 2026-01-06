import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/bottom_nav_bar.dart'; 
import '../controller/navigation_controller.dart';
import 'match_screen.dart'; 
import '../widgets/filter_modal_sheet.dart';
// Ensure this import exists for the navigation to work
import 'full_details_screen.dart'; 

class DiscoverScreen extends StatefulWidget {
  final int? forcedIndex; 
  const DiscoverScreen({super.key, this.forcedIndex});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
   final int _currentIndex = 0;
   
 final List<Profile> _profiles = [
    // Existing Data
    Profile(
      name: 'Jessica Parker',
      age: 23,
      job: 'Professional model',
      image: 'assets/images/p1.png', 
      distance: '1 km',
    ),
    Profile(
      name: 'Camila Snow',
      age: 23,
      job: 'Marketer',
      image: 'assets/images/p2.png',
      distance: '2 km',
    ),
    Profile(
      name: 'Bred Jackson',
      age: 25,
      job: 'Photographer',
      image: 'assets/images/p3.jpg',
      distance: '3 km',
    ),
    // New Dummy Data
    Profile(
      name: 'Sarah Miller',
      age: 24,
      job: 'UX Designer',
      image: 'assets/images/p5.jpg', 
      distance: '4 km',
    ),
    Profile(
      name: 'Emily Davis',
      age: 22,
      job: 'Art Student',
      image: 'assets/images/m3.jpg', 
      distance: '5 km',
    ),
    Profile(
      name: 'Michael Brown',
      age: 26,
      job: 'Software Engineer',
      image: 'assets/images/p3.jpg', 
      distance: '6 km',
    ),
    Profile(
      name: 'Olivia Wilson',
      age: 23,
      job: 'Architect',
      image: 'assets/images/m1.jpg', 
      distance: '8 km',
    ),
    Profile(
      name: 'Daniel Taylor',
      age: 27,
      job: 'Chef',
      image: 'assets/images/m3.jpg',
      distance: '10 km',
    ),
    Profile(
      name: 'Sophia Anderson',
      age: 21,
      job: 'Fashion Stylist',
      image: 'assets/images/c1.jpg',
      distance: '12 km',
    ),
    Profile(
      name: 'James Martin',
      age: 28,
      job: 'Entrepreneur',
      image: 'assets/images/p3.jpg',
      distance: '15 km',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SafeArea(
        child: Column(
          children: [
            /// 1. Header
            _buildHeader(),

            /// 2. Card Stack
            Expanded(
              child: _profiles.isEmpty
                  ? Center(
                      child: Text(
                        "No more profiles!",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    )
                  : Stack(
                      children: _profiles.asMap().entries.map((entry) {
                        final index = entry.key;
                        final profile = entry.value;
                        final isTop = index == _profiles.length - 1;

                        if (index < _profiles.length - 2) return const SizedBox();

                        return DraggableCard(
                          key: ValueKey(profile.name), 
                          profile: profile,
                          isTop: isTop,
                          onSwipeRight: _onLike,
                          onSwipeLeft: _onDislike,
                        );
                      }).toList(),
                    ),
            ),

            /// 3. Action Buttons
            Padding(
              padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  // --- 1. Dislike Button (Left) ---
                  _actionButton(
                    icon: Icons.close,
                    color: const Color(0xFFEC8E67), 
                    bg: Colors.white,
                    onTap: () {
                      if (_profiles.isNotEmpty) _onDislike();
                    },
                  ),
                  
                  20.horizontalSpace,

                  // --- 2. Info Button (Center - New) ---
                  _actionButton(
                    icon: Icons.info_rounded, // Info icon
                    color: const Color(0xFF7B61FF), // Purple color
                    bg: Colors.white,
                    onTap: () {
                      if (_profiles.isNotEmpty) {
                        // Get the top profile (the one currently visible)
                        final topProfile = _profiles.last;
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullDetailsScreen(
                              name: topProfile.name, 
                              image: topProfile.image
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  
                  20.horizontalSpace,

                  // --- 3. Like Button (Right - Replaced Star) ---
                  _largeActionButton(
                    icon: Icons.favorite,
                    onTap: () {
                      if (_profiles.isNotEmpty) _onLike();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: widget.forcedIndex ?? _currentIndex,
        onTap: (context, index) => NavigationController.navigateTo(context, index, _currentIndex),
      ),
    );
  }

  void _onLike() {
   /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MatchScreen()),
    );*/
    _removeTopCard();
  }

  void _onDislike() {
    _removeTopCard();
  }

  void _removeTopCard() {
    setState(() {
      _profiles.removeLast();
    });
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // REMOVED Back Button Icon, kept SizedBox to maintain layout spacing
          SizedBox(
            width: 50.w,
            height: 50.w,
          ),
          
          // Title
          Column(
            children: [
              Text(
                'Discover',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'SF Pro Display',
                ),
              ),
              Text(
                'Chicago, Il',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                  fontFamily: 'SF Pro Display',
                ),
              ),
            ],
          ),
          
          // Filter Button
           GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, 
                backgroundColor: Colors.transparent, 
                builder: (context) => const FilterModalSheet(),
              );
            },
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Icon(
                Icons.tune_rounded, 
                color: const Color(0xFFEC8E67),
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required Color bg,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 28.sp),
      ),
    );
  }

  Widget _largeActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 76.w,
        height: 76.w,
        decoration: BoxDecoration(
          color: const Color(0xFFEC8E67), // Primary Orange
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFEC8E67).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 36.sp),
      ),
    );
  }
}

// 🧊 The Swipeable Card Logic (Unchanged)
class DraggableCard extends StatefulWidget {
  final Profile profile;
  final bool isTop;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;

  const DraggableCard({
    super.key,
    required this.profile,
    required this.isTop,
    required this.onSwipeRight,
    required this.onSwipeLeft,
  });

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  Offset _position = Offset.zero;
  bool _isDragging = false;
  double _angle = 0;
  Size _screenSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;

    return widget.isTop
        ? GestureDetector(
            onPanStart: (details) => setState(() => _isDragging = true),
            onPanUpdate: (details) {
              setState(() {
                _position += details.delta;
                _angle = (_position.dx / _screenSize.width) * 0.3;
              });
            },
            onPanEnd: (details) {
              setState(() => _isDragging = false);
              final status = _getSwipeStatus();
              
              if (status == SwipeStatus.like) {
                _animateOffScreen(1); 
              } else if (status == SwipeStatus.dislike) {
                _animateOffScreen(-1); 
              } else {
                setState(() {
                  _position = Offset.zero;
                  _angle = 0;
                });
              }
            },
            child: LayoutBuilder(builder: (context, constraints) {
              return Transform.translate(
                offset: _position,
                child: Transform.rotate(
                  angle: _angle,
                  alignment: Alignment.bottomCenter,
                  child: _buildCard(),
                ),
              );
            }),
          )
        : _buildCard();
  }

  Future<void> _animateOffScreen(double direction) async {
    if (direction > 0) {
      widget.onSwipeRight();
    } else {
      widget.onSwipeLeft();
    }
  }

  SwipeStatus _getSwipeStatus() {
    final x = _position.dx;
    final threshold = 100.0;
    if (x >= threshold) return SwipeStatus.like;
    if (x <= -threshold) return SwipeStatus.dislike;
    return SwipeStatus.none;
  }

  Widget _buildCard() {
    return Center(
      child: Container(
        width: 325.w,
        height: 500.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                widget.profile.image,
                fit: BoxFit.cover,
                errorBuilder: (ctx, _, __) => Container(
                  color: Colors.grey.shade200,
                  child: const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),

              // Gradient Overlay (Bottom)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: const [0.5, 0.7, 1.0],
                    ),
                  ),
                ),
              ),

              // Text Info
              Positioned(
                bottom: 30.h,
                left: 20.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.profile.name}, ${widget.profile.age}',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.profile.job,
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),

              // Pagination Dots (Right)
              Positioned(
                right: 20.w,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      5,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(vertical: 2.h),
                        width: 4.w,
                        height: 4.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == 0
                              ? Colors.white
                              : Colors.white.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Distance Badge (Top Left)
              Positioned(
                top: 20.h,
                left: 20.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3), // Glass effect
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: Colors.white, size: 12.sp),
                      SizedBox(width: 4.w),
                      Text(
                        widget.profile.distance,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontFamily: 'SF Pro Display',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 🔥 OVERLAYS (Like/Dislike)
              if (widget.isTop) ...[
                _buildOverlay(SwipeStatus.like),
                _buildOverlay(SwipeStatus.dislike),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverlay(SwipeStatus status) {
    // Opacity logic based on drag position
    double opacity = 0.0;
    if (status == SwipeStatus.like && _position.dx > 0) {
      opacity = (_position.dx / 100).clamp(0.0, 1.0);
    } else if (status == SwipeStatus.dislike && _position.dx < 0) {
      opacity = (-_position.dx / 100).clamp(0.0, 1.0);
    }

    if (opacity == 0) return const SizedBox.shrink();

    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.4 * opacity),
        child: Center(
          child: Transform.scale(
            scale: 0.8 + (0.2 * opacity), // Pulse effect
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                status == SwipeStatus.like ? Icons.favorite : Icons.close,
                color: const Color(0xFFEC8E67),
                size: 50.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum SwipeStatus { like, dislike, none }

class Profile {
  final String name;
  final int age;
  final String job;
  final String image;
  final String distance;

  Profile({
    required this.name,
    required this.age,
    required this.job,
    required this.image,
    required this.distance,
  });
}