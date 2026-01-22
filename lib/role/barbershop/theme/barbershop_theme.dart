import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarbershopTheme {
  static const Color background = Color(0xFFF4F0E8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF1A1A1A);
  static const Color muted = Color(0xFF6F6A5F);
  static const Color accent = Color(0xFFE8B64A);
  static const Color accentDeep = Color(0xFFB7771C);
  static const Color forest = Color(0xFF1F3A2E);
  static const Color sea = Color(0xFF0F5E6B);
  static const Color chip = Color(0xFFEFE7D9);
  static const Color line = Color(0xFFE1D8C9);

  static LinearGradient heroGradient = const LinearGradient(
    colors: [Color(0xFFEDE3D2), Color(0xFFF6F1E6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static TextStyle display({Color? color}) {
    return GoogleFonts.dmSerifDisplay(
      color: color ?? ink,
      fontSize: 28,
      height: 1.1,
      letterSpacing: 0.2,
    );
  }

  static TextStyle title({Color? color}) {
    return GoogleFonts.spaceGrotesk(
      color: color ?? ink,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    );
  }

  static TextStyle body({Color? color}) {
    return GoogleFonts.spaceGrotesk(
      color: color ?? muted,
      fontSize: 13.5,
      height: 1.3,
    );
  }

  static TextStyle label({Color? color}) {
    return GoogleFonts.spaceGrotesk(
      color: color ?? muted,
      fontSize: 11.5,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
    );
  }
}
