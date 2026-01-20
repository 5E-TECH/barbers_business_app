import 'package:bar_brons_app/core/theme/app_colors.dart';
import 'package:bar_brons_app/role/barbershop/features/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return ListTile(
          leading: Icon(
            state.isDark ? Icons.dark_mode : Icons.light_mode,
            color: AppColors.yellow,
          ),
          title: Text(
            state.isDark ? "Tungi rejim" : "Kunduzgi rejim",
            style: TextStyle(
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
          trailing: Switch(
            value: state.isDark,
            activeTrackColor: AppColors.yellow.withValues(alpha: 0.5),
            activeThumbColor: AppColors.yellow,
            onChanged: (_) {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
          ),
        );
      },
    );
  }
}