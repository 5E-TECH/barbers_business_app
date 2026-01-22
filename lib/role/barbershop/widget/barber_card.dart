import 'package:crown_cuts/core/constance/api_constance.dart';
import 'package:crown_cuts/role/barbershop/barbers/logic/barbers_models.dart';
import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:crown_cuts/role/barbershop/widget/barber_details_bottom_sheet.dart';
import 'package:flutter/material.dart';

class BarberCard extends StatelessWidget {
  final BarberProfile barber;
  final int index;

  const BarberCard({super.key, required this.barber, this.index = 0});

  Widget _buildBarberImage({
    required String imageUrl,
    required String initials,
    required double width,
    required double height,
    required double borderRadius,
  }) {
    if (imageUrl.isEmpty) {
      return Text(
        initials,
        style: BarbershopTheme.title(color: Colors.white),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: width,
            height: height,
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white.withValues(alpha: 0.7),
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Text(
            initials,
            style: BarbershopTheme.title(color: Colors.white),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final initials = barber.fullName
        .split(' ')
        .take(2)
        .map((w) => w.isNotEmpty ? w[0].toUpperCase() : '')
        .join();

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 320 + index * 80),
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
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 72,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    BarbershopTheme.sea.withValues(alpha: 0.9),
                    BarbershopTheme.forest,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: _buildBarberImage(
                imageUrl: Constants.getImageUrl(barber.imagePath),
                initials: initials,
                width: 64,
                height: 72,
                borderRadius: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    barber.fullName,
                    style: BarbershopTheme.title(),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        barber.isAvailable
                            ? Icons.check_circle
                            : Icons.cancel,
                        size: 14,
                        color: barber.isAvailable
                            ? BarbershopTheme.forest
                            : BarbershopTheme.muted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        barber.isAvailable ? 'Available' : 'Unavailable',
                        style: BarbershopTheme.body(),
                      ),
                    ],
                  ),
                  if (barber.bio.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      barber.bio,
                      style: BarbershopTheme.body(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: BarbershopTheme.chip,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                size: 14, color: BarbershopTheme.accentDeep),
                            const SizedBox(width: 4),
                            Text(
                              barber.averageRating.isNotEmpty
                                  ? barber.averageRating
                                  : '0.0',
                              style: BarbershopTheme.body(
                                  color: BarbershopTheme.ink),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (barber.services.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: BarbershopTheme.chip,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${barber.services.length} services',
                            style:
                                BarbershopTheme.body(color: BarbershopTheme.ink),
                          ),
                        ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => BarberDetailsBottomSheet.show(context, barber),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: BarbershopTheme.forest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View Details',
                              style:
                                  BarbershopTheme.body(color: Colors.white),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 14),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}