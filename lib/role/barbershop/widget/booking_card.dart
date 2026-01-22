import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final int index;

  const BookingCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + index * 80),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: BarbershopTheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: BarbershopTheme.line),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wash, cut, and style',
                    style: BarbershopTheme.title(),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Client wants a tidy fade with beard line-up.',
                    style: BarbershopTheme.body(),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      _metaChip(
                        icon: Icons.access_time,
                        label: '6:00 PM',
                      ),
                      _metaChip(
                        icon: Icons.attach_money,
                        label: '\$30-150',
                      ),
                      _metaChip(
                        icon: Icons.star,
                        label: '4.8',
                      ),
                      _metaChip(
                        icon: Icons.calendar_today,
                        label: 'Nov 27, 2024',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 68,
              height: 84,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    BarbershopTheme.accent.withValues(alpha: 0.9),
                    BarbershopTheme.accentDeep,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: Text(
                'VIP',
                style: BarbershopTheme.title(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metaChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: BarbershopTheme.chip,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: BarbershopTheme.muted),
          const SizedBox(width: 6),
          Text(label, style: BarbershopTheme.body(color: BarbershopTheme.ink)),
        ],
      ),
    );
  }
}
