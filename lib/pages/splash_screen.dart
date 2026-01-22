import 'package:crown_cuts/core/theme/app_colors.dart';
import 'package:crown_cuts/main_screen.dart';
import 'package:crown_cuts/pages/login_screen.dart';
import 'package:crown_cuts/role/barbershop/auth/logic/barbershop_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthState();
    });
  }

  Future<void> _checkAuthState() async {
    final authProvider = context.read<BarberShopAuthProvider>();

    // Try auto login
    final isLoggedIn = await authProvider.tryAutoLogin();

    if (!mounted) return;

    // Navigate based on auth state
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isLoggedIn ? const MainScreen() : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: AppColors.yellow.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.content_cut_rounded,
                color: AppColors.yellow,
                size: 50,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'StyleUP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'business',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(
              color: AppColors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}