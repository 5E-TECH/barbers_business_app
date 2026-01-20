import 'package:bar_brons_app/core/theme/app_colors.dart';
import 'package:bar_brons_app/pages/sign_in.dart';
import 'package:bar_brons_app/role/barbershop/service/auth_service.dart';
import 'package:flutter/material.dart';

class HairdressersPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  HairdressersPage({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    await _authService.singOut();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        actions: [
          IconButton(
            onPressed: () => _handleLogout(context),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text("Hairdressers", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
