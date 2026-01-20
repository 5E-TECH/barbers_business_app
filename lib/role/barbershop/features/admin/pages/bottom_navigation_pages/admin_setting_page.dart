import 'package:bar_brons_app/core/theme/app_colors.dart';
import 'package:bar_brons_app/core/widgets/theme_toggle_widget.dart';
import 'package:bar_brons_app/pages/sign_in.dart';
import 'package:bar_brons_app/role/barbershop/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminSettingsPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  AdminSettingsPage({super.key});

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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sozlamalar",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _handleLogout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        children: [
          const ThemeToggleWidget(),
          const Divider(),
          ListTile(
            leading: Icon(Icons.person, color: AppColors.yellow),
            title: Text(
              "Profil",
              style: TextStyle(color: theme.appBarTheme.foregroundColor),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: theme.appBarTheme.foregroundColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: AppColors.yellow),
            title: Text(
              "Bildirishnomalar",
              style: TextStyle(color: theme.appBarTheme.foregroundColor),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: theme.appBarTheme.foregroundColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.info, color: AppColors.yellow),
            title: Text(
              "Ilova haqida",
              style: TextStyle(color: theme.appBarTheme.foregroundColor),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: theme.appBarTheme.foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
