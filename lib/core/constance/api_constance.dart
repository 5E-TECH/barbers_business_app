class Constants {
  static const baseUrl = "https://hucker.uz/barber/api/v1";
  static const imageBaseUrl = "https://hucker.uz/barber";

  /// Builds full image URL from relative path
  static String getImageUrl(String? path) {
    if (path == null || path.isEmpty || path == 'null') return '';
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    // Ensure path starts with /
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return '$imageBaseUrl$normalizedPath';
  }
}


class ApiEndpoints {
  static const barberShopSignIn = "/barber-shop/Singin";
  static const barberShopSignUp = "/barber-shop/Signup";
  static const barberShopMyAccount = "/barber-shop/My_Accaunt";
  static const barberAllMyBarbers = "/barber/all-myBarbers";
  static const barberCreate = "/barber/create";
  static const barberScheduleCreate = "/barber-schedule";
}
