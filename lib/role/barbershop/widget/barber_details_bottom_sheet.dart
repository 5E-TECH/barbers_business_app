import 'package:crown_cuts/core/constance/api_constance.dart';
import 'package:crown_cuts/role/barbershop/barbers/logic/barbers_models.dart';
import 'package:crown_cuts/role/barbershop/pages/barber_schedule_screen.dart';
import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:provider/provider.dart';
import 'package:crown_cuts/role/barbershop/barbers/logic/barbers_provider.dart';
import 'package:flutter/material.dart';

class BarberDetailsBottomSheet extends StatelessWidget {
  final BarberProfile barber;

  const BarberDetailsBottomSheet({super.key, required this.barber});

  static void show(BuildContext context, BarberProfile barber) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BarberDetailsBottomSheet(barber: barber),
    );
  }

  Widget _buildBarberImage({
    required String imageUrl,
    required String initials,
  }) {
    if (imageUrl.isEmpty) {
      return Text(
        initials,
        style: BarbershopTheme.display(color: Colors.white),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imageUrl,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: 80,
            height: 80,
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
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
            style: BarbershopTheme.display(color: Colors.white),
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

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: BarbershopTheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: BarbershopTheme.line,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Header with avatar and name
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                BarbershopTheme.sea.withValues(alpha: 0.9),
                                BarbershopTheme.forest,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: _buildBarberImage(
                            imageUrl: Constants.getImageUrl(barber.imagePath),
                            initials: initials,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                barber.fullName,
                                style: BarbershopTheme.display(),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '@${barber.username}',
                                style: BarbershopTheme.body(),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _statusBadge(barber.isAvailable),
                                  const SizedBox(width: 8),
                                  _ratingBadge(barber.averageRating),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Contact info
                    _sectionTitle('Contact'),
                    const SizedBox(height: 12),
                    _infoRow(Icons.phone_outlined, 'Phone', barber.phoneNumber),
                    if (barber.role.isNotEmpty)
                      _infoRow(Icons.badge_outlined, 'Role', barber.role),
                    const SizedBox(height: 24),

                    // Bio
                    if (barber.bio.isNotEmpty) ...[
                      _sectionTitle('About'),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: BarbershopTheme.chip,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          barber.bio,
                          style: BarbershopTheme.body(color: BarbershopTheme.ink),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Services
                    if (barber.services.isNotEmpty) ...[
                      _sectionTitle('Services (${barber.services.length})'),
                      const SizedBox(height: 12),
                      ...barber.services.map((service) => _serviceCard(service)),
                      const SizedBox(height: 24),
                    ],

                    // Schedule
                    if (barber.schedules.isNotEmpty) ...[
                      _sectionTitle('Schedule'),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: BarbershopTheme.chip,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: barber.schedules
                              .asMap()
                              .entries
                              .map((entry) => _scheduleRow(
                                    entry.value,
                                    isLast:
                                        entry.key == barber.schedules.length - 1,
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: _actionButton(
                            icon: Icons.edit_outlined,
                            label: 'Edit',
                            color: BarbershopTheme.sea,
                            onTap: () {
                              Navigator.pop(context);
                              // TODO: Navigate to edit screen
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _actionButton(
                            icon: Icons.calendar_today_outlined,
                            label: 'Schedule',
                            color: BarbershopTheme.forest,
                            onTap: () async {
                              final rootNavigator =
                                  Navigator.of(context, rootNavigator: true);
                              final result = await rootNavigator.push<bool>(
                                MaterialPageRoute(
                                  builder: (context) => BarberScheduleScreen(
                                    barber: barber,
                                  ),
                                ),
                              );

                              if (result == true && context.mounted) {
                                context.read<BarbersProvider>().fetchMyBarbers();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: BarbershopTheme.label(),
    );
  }

  Widget _statusBadge(bool isAvailable) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isAvailable
            ? BarbershopTheme.forest.withValues(alpha: 0.1)
            : BarbershopTheme.muted.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAvailable ? Icons.check_circle : Icons.cancel,
            size: 14,
            color: isAvailable ? BarbershopTheme.forest : BarbershopTheme.muted,
          ),
          const SizedBox(width: 4),
          Text(
            isAvailable ? 'Available' : 'Unavailable',
            style: BarbershopTheme.body(
              color: isAvailable ? BarbershopTheme.forest : BarbershopTheme.muted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBadge(String rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: BarbershopTheme.accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 14,
            color: BarbershopTheme.accentDeep,
          ),
          const SizedBox(width: 4),
          Text(
            rating.isNotEmpty ? rating : '0.0',
            style: BarbershopTheme.body(color: BarbershopTheme.accentDeep),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: BarbershopTheme.chip,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: BarbershopTheme.sea),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: BarbershopTheme.label()),
              const SizedBox(height: 2),
              Text(
                value,
                style: BarbershopTheme.body(color: BarbershopTheme.ink),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _serviceCard(BarberService service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: BarbershopTheme.chip,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: BarbershopTheme.line),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: BarbershopTheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.content_cut,
              size: 20,
              color: BarbershopTheme.forest,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: BarbershopTheme.title(),
                ),
                if (service.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    service.description,
                    style: BarbershopTheme.body(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: BarbershopTheme.sea.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${service.durationMinutes} min',
              style: BarbershopTheme.body(color: BarbershopTheme.sea),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scheduleRow(BarberSchedule schedule, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: BarbershopTheme.line),
              ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              _formatDayOfWeek(schedule.dayOfWeek),
              style: BarbershopTheme.body(color: BarbershopTheme.ink),
            ),
          ),
          Expanded(
            child: Text(
              '${_formatTime(schedule.startTime)} - ${_formatTime(schedule.endTime)}',
              style: BarbershopTheme.body(color: BarbershopTheme.forest),
            ),
          ),
          if (schedule.breakTime > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: BarbershopTheme.surface,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${schedule.breakTime}m break',
                style: BarbershopTheme.label(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: BarbershopTheme.title(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDayOfWeek(String day) {
    final days = {
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
      'friday': 'Friday',
      'saturday': 'Saturday',
      'sunday': 'Sunday',
    };
    return days[day.toLowerCase()] ?? day;
  }

  String _formatTime(String time) {
    if (time.isEmpty) return '';
    // If already formatted, return as is
    if (time.contains(':') && time.length <= 5) return time;
    // Try to format HH:mm:ss to HH:mm
    final parts = time.split(':');
    if (parts.length >= 2) {
      return '${parts[0]}:${parts[1]}';
    }
    return time;
  }
}
