import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ana renk: butonlar, seçili tab, seçili chip (geçici)
  static const Color primary = Color(0xFF2F5D8A);

  // zeminler
  static const Color background = Color(0xFFF6F7F9);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE3E5E8);

  // yazılar
  static const Color textPrimary = Color(0xFF1F2328);
  static const Color textSecondary = Color(0xFF6B7280);

  // durumlar
  static const Color success = Color(0xFF2F7A4B);  // verified
  static const Color warning = Color(0xFFB7791F);  // pending, yıldızlar
  static const Color error = Color(0xFFC0392B);    // rejected, form hataları
}