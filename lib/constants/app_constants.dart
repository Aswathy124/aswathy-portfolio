import 'package:flutter/material.dart';

class AppColors {
  static const teal = Color(0xFF1D9E75);
  static const blue = Color(0xFF185FA5);
  static const tealLight = Color(0xFF5DCAA5);
  static const blueLight = Color(0xFF378ADD);
  static const tealDark = Color(0xFF0F6E56);
  static const blueDark = Color(0xFF0C447C);

  static const bg = Color(0xFF0A0F1E);
  static const bg2 = Color(0xFF0D1529);
  static const surface = Color(0xFF131B30);
  static const border = Color(0xFF1D9E7530);
  static const textPrimary = Color(0xFFE8F4F1);
  static const textMuted = Color(0xFF7DA8C0);

  static const gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [teal, blue],
  );

  static const gradientSoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x201D9E75), Color(0x20185FA5)],
  );

  static Shader get gradientShader => const LinearGradient(
    colors: [teal, blue],
  ).createShader(const Rect.fromLTWH(0, 0, 200, 50));
}

class AppStrings {
  // Personal Info
  static const name = 'Your Name';
  static const role = 'Flutter Developer';
  static const company = 'Inciem Business Consultants';
  static const email = 'aswathykannan523@gmail.com';
  static const linkedin = 'https://linkedin.com/in/aswathy-k-79a195233';
  static const github = 'https://github.com/Aswathy124';
  static const location = 'Kerala';

  static const heroTagline = 'Flutter Developer\n& Mobile Engineer';
  static const heroBio =
      'MCA graduate with 1+ year of industry experience building cross-platform mobile apps using Flutter.';
}
