import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color? accent;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = accent ?? BarbershopTheme.accent;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            BarbershopTheme.surface,
            BarbershopTheme.chip,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: BarbershopTheme.line),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: BarbershopTheme.display(color: BarbershopTheme.ink),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: accentColor, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: BarbershopTheme.body(),
          ),
        ],
      ),
    );
  }
}
