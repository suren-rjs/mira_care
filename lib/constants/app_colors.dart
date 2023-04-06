import 'dart:ui';

// ignore: library_private_types_in_public_api
_AppColors appColors = _AppColors.instance;

class _AppColors {
  _AppColors._();

  static final _AppColors instance = _AppColors._();

  final Color overlayText = const Color(0xFFF89739);
  final Color transparent = const Color(0x00ffffff);
  final Color white = const Color(0xFFFFFFFF);
  final Color white30 = const Color(0xBAFFFFFF);
  final Color black = const Color(0xFF000000);
  final Color scoreCardText = const Color(0xFF1D3E7D);
  final Color eventNote = const Color(0xFF001640);
  final Color textGray = const Color(0xFF949494);
  final Color borderGray = const Color(0xFFC0C0C0);
  final Color backgroundGray = const Color(0xFFE8E8E8);
  final Color red = const Color(0xFFD32323);
  final Color nonSleep = const Color(0xFFCFF3FF);
  final Color sleep = const Color(0xFF53C5EA);
  final Color deepSleep = const Color(0xFF1D3E7D);
  final Color event = const Color(0xFFF89739);
  final Color remCol1 = const Color(0xFFF9C200);
  final Color remCol2 = const Color(0xFFF97700);
  final Color remCol3 = const Color(0xFF00D9CC);
}
