import 'package:bar_brons_app/core/router/role_based_router.dart';
import 'package:bar_brons_app/core/theme/app_colors.dart';
import 'package:bar_brons_app/pages/sign_in.dart';
import 'package:bar_brons_app/role/barbershop/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthChecker extends StatelessWidget {
  final AuthService _authService = AuthService();

  AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _authService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.yellow),
            ),
          );
        }
        if (snapshot.data == true) {
          return FutureBuilder(
            future: _authService.getCurrentUserRole(),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.data != null) {
                return RoleBasedRouter.getHomePageForRole(roleSnapshot.data);
              }
              return SignInPage();
            },
          );
        }
        return SignInPage();
      },
    );
  }
}
