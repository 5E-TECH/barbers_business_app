import 'package:bar_brons_app/core/enum/user_role.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyIsLoggedIn = "is_logged_in";
  static const String _keyUserRole = "user_role";
  static const String _keyUsername = "username";

  static final Map<String, Map<String, dynamic>> _mockUser = {
    'barbershop': {'password': 'barbershop123', 'role': UserRole.BARBERSHOP},
    'barber': {'password': 'barber123', 'role': UserRole.HAIRDRESSERS},
  };

  Future<Map<String, dynamic>> signIn(
    String username,
    String password, {
    UserRole? expectedRole,
  }) async {
    if (_mockUser.containsKey(username) &&
        _mockUser[username]!["password"] == password) {
      final role = _mockUser[username]!["role"] as UserRole;
      if (expectedRole != null && role != expectedRole) {
        return {
          "success": false,
          "role": null,
          "message": "Selected account type does not match this user",
        };
      }

      // save to local storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, true);
      await prefs.setString(_keyUserRole, role.toString());
      await prefs.setString(_keyUsername, username);

      return {"success": true, "role": role, "message": "login successful"};
    }
    return {
      "success": false,
      "role": null,
      "message": "invalid username or password",
    };
  }

  Future<Map<String, dynamic>> singUp(
    String username,
    String password,
    UserRole role,
  ) async {
    if (_mockUser.containsKey(username)) {
      return {"success": false, "message": "Username already exists"};
    }
    _mockUser[username] = {"password": password, "role": role};

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserRole, role.toString());
    await prefs.setString(_keyUsername, username);

    return {
      'success': true,
      'role': role,
      'message': 'Registration successful',
    };
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  Future<UserRole?> getCurrentUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final roleString = prefs.getString(_keyUserRole);

    if (roleString == null) return null;

    return UserRole.values.firstWhere(
      (e) => e.toString() == roleString,
      orElse: () => UserRole.BARBERSHOP,
    );
  }

  Future<String?> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  Future<void> singOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUserRole);
    await prefs.remove(_keyUsername);
  }
}
