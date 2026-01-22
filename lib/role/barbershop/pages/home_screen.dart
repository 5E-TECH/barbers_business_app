import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:crown_cuts/role/barbershop/widget/revenue_bar.dart';
import 'package:crown_cuts/role/barbershop/widget/start_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            top: -40,
            right: -30,
            child: _blurCircle(BarbershopTheme.accent.withValues(alpha: 0.25)),
          ),
          Positioned(
            bottom: -60,
            left: -20,
            child: _blurCircle(BarbershopTheme.sea.withValues(alpha: 0.2)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: BarbershopTheme.forest,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.content_cut_rounded,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bar Brons', style: BarbershopTheme.display()),
                            Text('Owner Dashboard',
                                style: BarbershopTheme.body()),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: BarbershopTheme.chip,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.circle,
                                size: 10, color: BarbershopTheme.accentDeep),
                            const SizedBox(width: 6),
                            Text('Open', style: BarbershopTheme.body()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Today at a glance',
                      style: BarbershopTheme.title()),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Expanded(
                        child: StatCard(
                          value: '98',
                          label: 'Bookings',
                          icon: Icons.calendar_today,
                          accent: BarbershopTheme.sea,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          value: '15',
                          label: 'Listings',
                          icon: Icons.list_alt,
                          accent: BarbershopTheme.forest,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Expanded(
                        child: StatCard(
                          value: '30',
                          label: 'Reviews',
                          icon: Icons.star_outline,
                          accent: BarbershopTheme.accentDeep,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          value: '\$45.3',
                          label: 'Earnings',
                          icon: Icons.attach_money,
                          accent: BarbershopTheme.accent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text('Revenue pulse',
                          style: BarbershopTheme.title()),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: BarbershopTheme.forest,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Text('This Week',
                                style: BarbershopTheme.body(
                                    color: Colors.white)),
                            const SizedBox(width: 4),
                            const Icon(Icons.expand_more,
                                color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 12 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: BarbershopTheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: BarbershopTheme.line),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Monthly Revenue',
                              style: BarbershopTheme.title()),
                          const SizedBox(height: 4),
                          Text('USD per month',
                              style: BarbershopTheme.body()),
                          const SizedBox(height: 20),
                          const SizedBox(
                            height: 200,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RevenueBar(
                                    value: 5000,
                                    maxValue: 15000,
                                    label: 'Jan'),
                                RevenueBar(
                                    value: 10000,
                                    maxValue: 15000,
                                    label: 'Feb'),
                                RevenueBar(
                                    value: 13000,
                                    maxValue: 15000,
                                    label: 'Mar'),
                                RevenueBar(
                                    value: 8000,
                                    maxValue: 15000,
                                    label: 'Apr'),
                                RevenueBar(
                                    value: 0,
                                    maxValue: 15000,
                                    label: 'May'),
                                RevenueBar(
                                    value: 0,
                                    maxValue: 15000,
                                    label: 'Jun'),
                                RevenueBar(
                                    value: 0,
                                    maxValue: 15000,
                                    label: 'Jul'),
                                RevenueBar(
                                    value: 0,
                                    maxValue: 15000,
                                    label: 'Aug'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
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
