import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {

  AppTextStyles._();

  static const TextStyle title = TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
  static const TextStyle heading = TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
  static const TextStyle body = TextStyle(fontSize: 14);
  static const TextStyle label = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);
  static const TextStyle caption = TextStyle(fontSize: 12, color: AppColors.textSecondary);
}