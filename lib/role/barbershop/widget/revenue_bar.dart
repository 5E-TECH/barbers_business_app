import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:flutter/material.dart';

class RevenueBar extends StatelessWidget {
  final double value;
  final double maxValue;
  final String label;

  const RevenueBar({
    super.key,
    required this.value,
    required this.maxValue,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final height = (value / maxValue) * 150;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 22,
          height: 150,
          decoration: BoxDecoration(
            color: BarbershopTheme.chip,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 22,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  BarbershopTheme.sea,
                  BarbershopTheme.accent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: BarbershopTheme.label(),
        ),
      ],
    );
  }
}
