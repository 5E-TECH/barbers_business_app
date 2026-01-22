class BarberService {
  final String id;
  final String name;
  final String description;
  final int durationMinutes;

  const BarberService({
    required this.id,
    required this.name,
    required this.description,
    required this.durationMinutes,
  });

  factory BarberService.fromJson(Map<String, dynamic> json) {
    return BarberService(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 0,
    );
  }
}

class BarberSchedule {
  final String id;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final int breakTime;

  const BarberSchedule({
    required this.id,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.breakTime,
  });

  factory BarberSchedule.fromJson(Map<String, dynamic> json) {
    return BarberSchedule(
      id: json['id']?.toString() ?? '',
      dayOfWeek: json['day_of_week']?.toString() ?? '',
      startTime: json['start_time']?.toString() ?? '',
      endTime: json['end_time']?.toString() ?? '',
      breakTime: (json['break_time'] as num?)?.toInt() ?? 0,
    );
  }
}

class BarberProfile {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String username;
  final String bio;
  final String role;
  final String averageRating;
  final String imagePath;
  final bool isAvailable;
  final List<BarberService> services;
  final List<BarberSchedule> schedules;

  const BarberProfile({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.username,
    required this.bio,
    required this.role,
    required this.averageRating,
    required this.imagePath,
    required this.isAvailable,
    required this.services,
    required this.schedules,
  });

  factory BarberProfile.fromJson(Map<String, dynamic> json) {
    // Handle image path - can be null, "null" string, or actual path
    final rawImg = json['img'];
    final imagePath = (rawImg == null || rawImg.toString() == 'null')
        ? ''
        : rawImg.toString();

    return BarberProfile(
      id: json['id']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      phoneNumber: json['phone_number']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      bio: json['bio']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      averageRating: json['avg_reyting']?.toString() ?? '',
      imagePath: imagePath,
      isAvailable: json['is_avaylbl'] == true,
      services: (json['service'] as List<dynamic>? ?? [])
          .map((item) =>
              BarberService.fromJson(item as Map<String, dynamic>))
          .toList(),
      schedules: (json['barberSchuld'] as List<dynamic>? ?? [])
          .map((item) =>
              BarberSchedule.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class BarbersPage {
  final List<BarberProfile> data;
  final int total;
  final int currentPage;
  final int pageSize;
  final int totalPages;

  const BarbersPage({
    required this.data,
    required this.total,
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
  });

  factory BarbersPage.fromJson(Map<String, dynamic> json) {
    return BarbersPage(
      data: (json['data'] as List<dynamic>? ?? [])
          .map((item) =>
              BarberProfile.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt() ?? 0,
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
    );
  }
}
