import 'package:bar_brons_app/role/barbershop/features/theme/bloc/theme_bloc.dart';
import 'package:bar_brons_app/role/barbershop/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 844),
            child: MaterialApp(
              theme: state.themeData,
              debugShowCheckedModeBanner: false,
              home: const SplashPageSlideUp(),
            ),
          );
        },
      ),
    );
  }
}
