import 'package:bar_brons_app/features/customer/pages/bottom_navigation_pages/admin_home_page.dart';
import 'package:bar_brons_app/features/customer/pages/bottom_navigation_pages/admin_get_bron_page.dart';
import 'package:bar_brons_app/features/customer/pages/bottom_navigation_pages/admin_setting_page.dart';
import 'package:bar_brons_app/features/customer/pages/bottom_navigation_pages/admin_history_page.dart';
import 'package:flutter/material.dart';


class AdvancedCurvedBottomNav extends StatefulWidget {
  const AdvancedCurvedBottomNav({super.key});

  @override
  State<AdvancedCurvedBottomNav> createState() => _AdvancedCurvedBottomNavState();
}

class _AdvancedCurvedBottomNavState extends State<AdvancedCurvedBottomNav>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<NavBarItem> _items = [
    NavBarItem(icon: Icons.maps_home_work_outlined, label: "Sartaroshxonalar"),
    NavBarItem(icon: Icons.home_repair_service, label: "Bron qilish"),
    NavBarItem(icon: Icons.history_edu_outlined, label: "Tarix"),
    NavBarItem(icon: Icons.settings_outlined, label: "Sozlamalar"),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          AdminHomePage(),
          AdminGetBronPage(),
          AdminHistoryPage(),
          AdminSettingsPage(),
        ],
      ),
      bottomNavigationBar: CurvedBottomNavigationBar(
        selectedIndex: _selectedIndex,
        items: _items,
        onTap: _onItemTapped,
        animation: _animation,
      ),
    );
  }
}

class NavBarItem {
  final IconData icon;
  final String label;

  NavBarItem({required this.icon, required this.label});
}

class CurvedBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final List<NavBarItem> items;
  final Function(int) onTap;
  final Animation<double> animation;

  const CurvedBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.items,
    required this.onTap,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background with curve
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 75),
            painter: CurvedNavigationBarPainter(
              selectedIndex: selectedIndex,
              itemCount: items.length,
              animation: animation,
            ),
          ),

          // Floating selected button
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return AnimatedPositioned(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                left: _getSelectedPosition(context),
                top: -20,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFA500),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        items[selectedIndex].icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Navigation items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = index == selectedIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: isSelected ? 30 : 0.5),
                        if (!isSelected)
                          Icon(
                            items[index].icon,
                            color: Colors.white,
                            size: 30,
                          ),
                        if (!isSelected) SizedBox(height: 4),
                        if (!isSelected)
                          Text(
                            items[index].label,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  double _getSelectedPosition(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / items.length;
    final centerOffset = (itemWidth - 65) / 2;
    return (selectedIndex * itemWidth) + centerOffset;
  }
}

class CurvedNavigationBarPainter extends CustomPainter {
  final int selectedIndex;
  final int itemCount;
  final Animation<double> animation;

  CurvedNavigationBarPainter({
    required this.selectedIndex,
    required this.itemCount,
    required this.animation,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.fill;

    final path = Path();
    final itemWidth = size.width / itemCount;
    final curveStartX = selectedIndex * itemWidth;
    final curveEndX = (selectedIndex + 1) * itemWidth;
    final curveCenterX = curveStartX + (itemWidth / 2);

    // Start from left
    path.lineTo(curveStartX, 0);

    // Create curve for selected item
    final curveHeight = 20.0;
    final curveWidth = itemWidth * 0.9;
    final controlPoint1X = curveCenterX - (curveWidth / 3);
    final controlPoint2X = curveCenterX + (curveWidth / 3);

    path.quadraticBezierTo(
      controlPoint1X,
      -curveHeight,
      curveCenterX,
      -curveHeight,
    );

    path.quadraticBezierTo(
      controlPoint2X,
      -curveHeight,
      curveEndX,
      0,
    );

    // Continue to right
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Add shadow
    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.3), 5, true);
  }

  @override
  bool shouldRepaint(CurvedNavigationBarPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.animation != animation;
  }
}