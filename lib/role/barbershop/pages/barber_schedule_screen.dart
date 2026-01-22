import 'package:crown_cuts/role/barbershop/barbers/logic/barbers_models.dart';
import 'package:crown_cuts/role/barbershop/barbers_schedule/logic/barber_schedule_models.dart';
import 'package:crown_cuts/role/barbershop/barbers_schedule/logic/barber_schedule_provider.dart';
import 'package:crown_cuts/role/barbershop/theme/barbershop_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarberScheduleScreen extends StatefulWidget {
  final BarberProfile barber;

  const BarberScheduleScreen({super.key, required this.barber});

  @override
  State<BarberScheduleScreen> createState() => _BarberScheduleScreenState();
}

class _BarberScheduleScreenState extends State<BarberScheduleScreen> {
  final List<String> _days = const [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  String _startDay = 'monday';
  String _endDay = 'friday';
  String _startTime = '09:00:00';
  String _endTime = '17:00:00';
  final TextEditingController _breakController =
      TextEditingController(text: '10');

  @override
  void dispose() {
    _breakController.dispose();
    super.dispose();
  }

  Future<void> _pickTime({
    required bool isStart,
  }) async {
    final initial = isStart ? _startTime : _endTime;
    final parts = initial.split(':');
    final initialTime = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 9,
      minute: int.tryParse(parts[1]) ?? 0,
    );

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked == null) return;

    final formatted =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00';

    setState(() {
      if (isStart) {
        _startTime = formatted;
      } else {
        _endTime = formatted;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = context.watch<BarberScheduleProvider>();
    final barberId = int.tryParse(widget.barber.id) ?? 0;

    return Scaffold(
      backgroundColor: BarbershopTheme.background,
      appBar: AppBar(
        backgroundColor: BarbershopTheme.background,
        elevation: 0,
        title: Text('Create Schedule', style: BarbershopTheme.title()),
        iconTheme: const IconThemeData(color: BarbershopTheme.ink),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.barber.fullName, style: BarbershopTheme.display()),
              const SizedBox(height: 6),
              Text('@${widget.barber.username}', style: BarbershopTheme.body()),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: BarbershopTheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: BarbershopTheme.line),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Day Range', style: BarbershopTheme.label()),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDayDropdown(
                            value: _startDay,
                            onChanged: (value) =>
                                setState(() => _startDay = value),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDayDropdown(
                            value: _endDay,
                            onChanged: (value) =>
                                setState(() => _endDay = value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text('Working Hours', style: BarbershopTheme.label()),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _timeField(
                            label: 'Start',
                            value: _startTime,
                            onTap: () => _pickTime(isStart: true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _timeField(
                            label: 'End',
                            value: _endTime,
                            onTap: () => _pickTime(isStart: false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text('Break (minutes)', style: BarbershopTheme.label()),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: BarbershopTheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: BarbershopTheme.line),
                      ),
                      child: TextField(
                        controller: _breakController,
                        keyboardType: TextInputType.number,
                        style: BarbershopTheme.body(color: BarbershopTheme.ink),
                        decoration: InputDecoration(
                          hintText: '10',
                          hintStyle: BarbershopTheme.body(),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: scheduleProvider.isLoading
                            ? null
                            : () async {
                                if (barberId == 0) {
                                  _showMessage(
                                      'Invalid barber id. Please try again.');
                                  return;
                                }

                                final breakTime =
                                    int.tryParse(_breakController.text) ?? 0;

                                final request = BarberScheduleCreateRequest(
                                  startDay: _startDay,
                                  endDay: _endDay,
                                  startTime: _startTime,
                                  endTime: _endTime,
                                  breakTime: breakTime,
                                  barberId: barberId,
                                );

                                final success = await context
                                    .read<BarberScheduleProvider>()
                                    .createSchedule(request: request);

                                if (!mounted) return;

                                if (success) {
                                  _showMessage('Schedule created successfully.');
                                  Navigator.pop(context, true);
                                } else {
                                  _showMessage(
                                    context
                                            .read<BarberScheduleProvider>()
                                            .errorMessage ??
                                        'Failed to create schedule.',
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BarbershopTheme.forest,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (scheduleProvider.isLoading)
                              const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            else
                              Text(
                                'Save Schedule',
                                style: BarbershopTheme.body(
                                  color: Colors.white,
                                ).copyWith(fontWeight: FontWeight.w600),
                              ),
                            const SizedBox(width: 8),
                            const Icon(Icons.check, color: Colors.white, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayDropdown({
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: BarbershopTheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: BarbershopTheme.line),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.expand_more, color: BarbershopTheme.muted),
          dropdownColor: BarbershopTheme.surface,
          style: BarbershopTheme.body(color: BarbershopTheme.ink),
          items: _days
              .map(
                (day) => DropdownMenuItem<String>(
                  value: day,
                  child: Text(_titleCase(day)),
                ),
              )
              .toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ),
    );
  }

  Widget _timeField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: BarbershopTheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: BarbershopTheme.line),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '$label: ${_formatTime(value)}',
                style: BarbershopTheme.body(color: BarbershopTheme.ink),
              ),
            ),
            const Icon(Icons.access_time, size: 18, color: BarbershopTheme.muted),
          ],
        ),
      ),
    );
  }

  String _formatTime(String value) {
    if (value.length < 5) return value;
    return value.substring(0, 5);
  }

  String _titleCase(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
