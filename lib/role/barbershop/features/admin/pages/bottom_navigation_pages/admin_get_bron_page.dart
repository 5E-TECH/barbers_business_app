import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminGetBronPage extends StatefulWidget {
  const AdminGetBronPage({super.key});

  @override
  State<AdminGetBronPage> createState() => _AdminGetBronPageState();
}

class _AdminGetBronPageState extends State<AdminGetBronPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          "Bron Olish",
          style: TextStyle(
            color: theme.appBarTheme.foregroundColor,
            fontSize: 40.sp,
          ),
        ),
      ),
    );
  }
}
