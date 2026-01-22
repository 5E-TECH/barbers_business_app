import 'package:crown_cuts/pages/splash_screen.dart';
import 'package:crown_cuts/role/barbershop/auth/logic/barbershop_auth_provider.dart';
import 'package:crown_cuts/role/barbershop/barbers/logic/barbers_provider.dart';
import 'package:crown_cuts/role/barbershop/barbers_schedule/logic/barber_schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BarberShopAuthProvider()),
        ChangeNotifierProvider(create: (_) => BarbersProvider()),
        ChangeNotifierProvider(create: (_) => BarberScheduleProvider()),
      ],
      child: MaterialApp(
        title: 'Crown Cuts',
        theme: AppTheme.light,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
