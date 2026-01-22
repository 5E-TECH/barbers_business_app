import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:crown_cuts/role/barbershop/widget/booking_card.dart';
import 'package:flutter/material.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int selectedTab = 0;
  int selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BarbershopTheme.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: BarbershopTheme.heroGradient,
              ),
            ),
          ),
          Positioned(
            top: -20,
            right: -10,
            child:
                _blurCircle(BarbershopTheme.accent.withValues(alpha: 0.22)),
          ),
          Positioned(
            bottom: -50,
            left: -10,
            child: _blurCircle(BarbershopTheme.forest.withValues(alpha: 0.18)),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bookings',
                                style: BarbershopTheme.display()),
                            Text('Track requests and schedule',
                                style: BarbershopTheme.body()),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: BarbershopTheme.chip,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 16, color: BarbershopTheme.ink),
                            const SizedBox(width: 6),
                            Text('Week View',
                                style: BarbershopTheme.body(
                                    color: BarbershopTheme.ink)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: BarbershopTheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: BarbershopTheme.line),
                    ),
                    child: Row(
                      children: [
                        _buildTab(0, 'Requests'),
                        _buildTab(1, 'Upcoming'),
                        _buildTab(2, 'History'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      _buildFilterChip(0, 'General'),
                      const SizedBox(width: 10),
                      _buildFilterChip(1, 'Direct'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: BarbershopTheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: BarbershopTheme.line),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search bookings or clients...',
                        hintStyle: BarbershopTheme.body(),
                        border: InputBorder.none,
                        icon: const Icon(Icons.search,
                            color: BarbershopTheme.muted),
                      ),
                      style: BarbershopTheme.body(color: BarbershopTheme.ink),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return BookingCard(index: index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String title) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? BarbershopTheme.forest : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: BarbershopTheme.body(
              color: isSelected ? Colors.white : BarbershopTheme.muted,
            ).copyWith(fontWeight: FontWeight.w600, fontSize: 12.5),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(int index, String label) {
    final isSelected = selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? BarbershopTheme.accent : BarbershopTheme.chip,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: BarbershopTheme.body(
            color: isSelected ? BarbershopTheme.ink : BarbershopTheme.muted,
          ).copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _blurCircle(Color color) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
