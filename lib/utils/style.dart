import 'package:cardnews/utils/colors.dart';
import 'package:flutter/material.dart';

abstract class AppStyle {
  static TextStyle m12b = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: Colors.black.withOpacity(.6),
  );

  static TextStyle m12bt = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.black.withOpacity(0.9));

  static TextStyle m18bt = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.black.withOpacity(0.9));

  static TextStyle m12rt = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.black.withOpacity(0.9));

  static TextStyle m12prt = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.purple);

  static TextStyle m12w = const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black);

  static TextStyle r16w = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black);

  static TextStyle r10wt = const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black);

  static TextStyle b32w = const TextStyle(
      fontSize: 32, fontWeight: FontWeight.w600, color: Colors.black);
}
