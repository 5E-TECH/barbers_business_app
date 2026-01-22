class BarberScheduleCreateRequest {
  final String startDay;
  final String endDay;
  final String startTime;
  final String endTime;
  final int breakTime;
  final int barberId;

  const BarberScheduleCreateRequest({
    required this.startDay,
    required this.endDay,
    required this.startTime,
    required this.endTime,
    required this.breakTime,
    required this.barberId,
  });
}

class BarberScheduleEntry {
  final String id;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final int breakTime;
  final int barberId;

  const BarberScheduleEntry({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.breakTime,
    required this.barberId,
  });

  factory BarberScheduleEntry.fromJson(Map<String, dynamic> json) {
    return BarberScheduleEntry(
      id: json['id']?.toString() ?? '',
      dayOfWeek: json['day_of_week']?.toString() ?? '',
      startTime: json['start_time']?.toString() ?? '',
      endTime: json['end_time']?.toString() ?? '',
      breakTime: (json['break_time'] as num?)?.toInt() ?? 0,
      barberId: (json['barber_id'] as num?)?.toInt() ?? 0,
    );
  }
}

class BarberScheduleCreateResult {
  final List<BarberScheduleEntry> schedules;
  final int totalDays;
  final String message;

  const BarberScheduleCreateResult({
    required this.schedules,
    required this.totalDays,
    required this.message,
  });

  factory BarberScheduleCreateResult.fromJson(Map<String, dynamic> json) {
    return BarberScheduleCreateResult(
      schedules: (json['schedules'] as List<dynamic>? ?? [])
          .map((item) =>
              BarberScheduleEntry.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalDays: (json['totalDays'] as num?)?.toInt() ?? 0,
      message: json['message']?.toString() ?? '',
    );
  }
}
