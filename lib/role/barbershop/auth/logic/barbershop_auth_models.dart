class AuthTokens {
  final String accessToken;
  final String refreshToken;

  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
  });
}

class BarberShopOwnerSignupRequest {
  final String name;
  final String location;
  final double latitude;
  final double longitude;
  final String password;
  final String username;
  final String description;
  final String phoneNumber;

  const BarberShopOwnerSignupRequest({
    required this.name,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.password,
    required this.username,
    required this.description,
    required this.phoneNumber,
  });
}

class BarberShopAccount {
  final String id;
  final String name;
  final String location;
  final double latitude;
  final double longitude;
  final String imagePath;
  final String description;
  final String phoneNumber;
  final String username;
  final String role;
  final String status;
  final String averageRating;
  final List<BarberShopBarber> barbers;

  const BarberShopAccount({
    required this.id,
    required this.name,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.imagePath,
    required this.description,
    required this.phoneNumber,
    required this.username,
    required this.role,
    required this.status,
    required this.averageRating,
    required this.barbers,
  });

  factory BarberShopAccount.fromJson(Map<String, dynamic> json) {
    return BarberShopAccount(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      imagePath: json['img']?.toString() ?? '',
      description: json['description']?.toString() ??
          json['descripton']?.toString() ??
          '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      averageRating: json['avg_rating']?.toString() ?? '',
      barbers: (json['barber'] as List<dynamic>? ?? [])
          .map((item) =>
              BarberShopBarber.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class BarberShopBarber {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String username;
  final String bio;
  final String role;
  final String averageRating;
  final String imagePath;
  final bool isAvailable;

  const BarberShopBarber({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.username,
    required this.bio,
    required this.role,
    required this.averageRating,
    required this.imagePath,
    required this.isAvailable,
  });

  factory BarberShopBarber.fromJson(Map<String, dynamic> json) {
    return BarberShopBarber(
      id: json['id']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      phoneNumber: json['phone_number']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      bio: json['bio']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      averageRating: json['avg_reyting']?.toString() ?? '',
      imagePath: json['img']?.toString() ?? '',
      isAvailable: json['is_avaylbl'] == true,
    );
  }
}
