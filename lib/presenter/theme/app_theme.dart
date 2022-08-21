import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:square_tickets/presenter/theme/app_colors.dart';

class Apptheme {
  Apptheme._();

  static ThemeData lightTheme = ThemeData(
    // fontFamily: 'Poppins',
    textTheme: GoogleFonts.getTextTheme('Open Sans'),


    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    backgroundColor: Colors.white,
    cardColor: AppColors.cardColorLight,
    cardTheme:  CardTheme(color: Colors.grey.shade100),
    colorScheme: const ColorScheme.light(
        background: Colors.white,
        primary: AppColors.primarycolor, onPrimary: AppColors.PtextColor),
    scaffoldBackgroundColor: AppColors.smokeWhite,
    bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
        backgroundColor:AppColors.smokeWhite),
    secondaryHeaderColor: const Color(0xfffc2700e),
    primaryColor: const Color(0xfffc2700e),
    primaryColorLight: const Color(0xfffc2700e),

  );
  static ThemeData darktTheme = ThemeData(
    // fontFamily: GoogleFonts.fa,
    dialogBackgroundColor: AppColors.cardColor ,
    textTheme: GoogleFonts.getTextTheme('PT Sans'),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.cardColor),
    cardColor: AppColors.cardColor,
    cardTheme: const CardTheme(color: AppColors.cardColor),

    colorScheme: const ColorScheme.light(
      background: AppColors.sccafoldBg,
        primary:AppColors.primarycolor, onPrimary: Colors.white),
    scaffoldBackgroundColor: AppColors.sccafoldBg,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.sccafoldBg),
    secondaryHeaderColor: const Color(0xfffc2700e),
    primaryColor: const Color(0xfffc2700e),
    primaryColorDark: Colors.black87,
    primaryColorLight: const Color(0xfffc2700e),
  );

  static InputDecoration textFieldDecoration = const InputDecoration();
  static InputDecoration filledTextFieldDecoration = InputDecoration(
    filled: true,
   contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
    border: OutlineInputBorder(
   gapPadding: 2,
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
  );
  static TextStyle tittleTextStyle =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
}
