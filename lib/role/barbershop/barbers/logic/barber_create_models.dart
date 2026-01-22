class BarberCreateRequest {
  final String fullName;
  final String phoneNumber;
  final String password;
  final String username;
  final String bio;

  const BarberCreateRequest({
    required this.fullName,
    required this.phoneNumber,
    required this.password,
    required this.username,
    required this.bio,
  });
}

class BarberCreateResult {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String username;
  final String bio;
  final String role;
  final String imagePath;
  final bool isAvailable;
  final String barberShopId;

  const BarberCreateResult({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.username,
    required this.bio,
    required this.role,
    required this.imagePath,
    required this.isAvailable,
    required this.barberShopId,
  });

  factory BarberCreateResult.fromJson(Map<String, dynamic> json) {
    final barberShop = json['barberShop'] as Map<String, dynamic>? ?? {};
    return BarberCreateResult(
      id: json['id']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      phoneNumber: json['phone_number']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      bio: json['bio']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      imagePath: json['img']?.toString() ?? '',
      isAvailable: json['is_avaylbl'] == true,
      barberShopId: barberShop['id']?.toString() ?? '',
    );
  }
}
