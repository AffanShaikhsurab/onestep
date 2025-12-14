/// Application color palette based on "Mindful Moments" design system
library app_colors;

import 'package:flutter/material.dart';

class AppColors {
  // Background Colors
  static const Color background = Color(0xFFF9F8F4);
  static const Color surface = Color(0xFFFFFFFF);
  
  // Primary Colors
  static const Color primaryGreen = Color(0XFFaed581);
  static const Color primary = primaryGreen;
  
  // Gradient Colors
  static const Color gradientStart = Color(0xFF008160);
  static const Color gradientEnd = Color(0xFF4AC698);
  
  // Accent Colors
  static const Color accentLime = Color(0xFFDCF563);
  static const Color accent = accentLime;
  static const Color accentPink = Color(0xFFF28B82);
  static const Color accentLilac = Color(0xFFCE93D8);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1d2129);
  static const Color textPrimaryDark = Color(0xFFF7FAFC);
  static const Color textSecondary = Color(0xFF606770);
  static const Color textSecondaryDark = Color(0xFFCBD5E0);
  static const Color textTertiary = Color(0xFF9B9B9B);
  static const Color textTertiaryDark = Color(0xFF8B8B8B);
  
  // Success Color
  static const Color successGreen = Color(0xFF4CAF50);
  
  // Legacy/Compatibility Colors
  static const Color primaryBlue = primaryGreen;
  static const Color darkBlue = Color(0xFF008160);
  static const Color lightBlue = Color(0xFFE3F8EB);
  
  static const Color primaryLight = Color(0xFFB8D19A);
  static const Color primaryDark = gradientStart;
  
  static const Color secondary = textSecondary;
  static const Color secondaryLight = Color(0xFFC0C0C0);
  static const Color secondaryDark = Color(0xFF808080);
  
  static const Color accentLight = Color(0xFFF0F8E8);
  static const Color accentLavender = accentLilac;
  static const Color accentInactiveGray = textSecondary;
  
  // Background variations
  static const Color lightSkyBlue = Color(0xFFF0F8E8);
  static const Color paleYellow = Color(0xFFE8F5E9);
  static const Color softPeach = background;
  static const Color pureWhite = surface;
  static const Color lightOrange = background;
  static const Color backgroundGradient = background;
  static const Color backgroundGradientEnd = Color(0xFFF5F4F0);
  
  static const Color backgroundDark = Color(0xFF1C1C1E);
  static const Color surfaceContainer = Color(0xFFFDFDFD);
  static const Color surfaceContainerDark = Color(0xFF1C1C1E);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color surfaceVariant = Color(0xFFF8F9FB);
  static const Color surfaceVariantDark = Color(0xFF404040);
  
  // Status Colors
  static const Color success = Color(0xFF2e7d32);
  static const Color warning = Color(0xFFe59a4c);
  static const Color error = Color(0xFF8B4A4A);
  static const Color info = primaryBlue;
  
  // Border Colors
  static const Color border = Color(0xFFeef0f3);
  static const Color borderDark = Color(0xFF505050);
  
  // Shadow Colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowStrong = Color(0x33000000);
  static const Color blueShadow = Color(0x664B7BEC);
  
  // Identity Category Colors
  static const List<Color> identityColors = [
    primaryBlue,
    darkBlue,
    Color(0xFF6B8FEE),
    Color(0xFF3867d6),
    Color(0xFF2E5CB8),
    Color(0xFF1E3A8A),
    Color(0xFF606770),
    Color(0xFF8B929B),
  ];
  
  // Habit Streak Colors
  static const Color streakBronze = Color(0xFF606770);
  static const Color streakSilver = Color(0xFF8B929B);
  static const Color streakGold = primaryBlue;
  static const Color streakPlatinum = darkBlue;
  
  // Additional Colors
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color outline = Color(0xFFE5E5E5);

  // Dark Theme Button Colors
  static const Color buttonPrimaryDark = Color(0xFF505050);
  static const Color buttonPrimaryDarkHover = Color(0xFF6B6B6B);
  static const Color buttonPrimaryDarkActive = Color(0xFF404040);
  static const Color buttonPrimaryDarkDisabled = Color(0xFF4A5568);
  
  static const Color buttonSecondaryDark = Color(0xFFA0522D);
  static const Color buttonSecondaryDarkHover = Color(0xFFB8956F);
  static const Color buttonSecondaryDarkActive = Color(0xFF8B4513);
  static const Color buttonSecondaryDarkDisabled = Color(0xFF4A5568);
  
  static const Color buttonOutlineDark = Color(0xFF505050);
  static const Color buttonOutlineDarkHover = Color(0xFF1A2332);
  static const Color buttonOutlineDarkActive = Color(0xFF2D3748);
  static const Color buttonOutlineDarkDisabled = Color(0xFF4A5568);
  
  static const Color buttonTextDark = Color(0xFF505050);
  static const Color buttonTextDarkHover = Color(0xFF1A2332);
  static const Color buttonTextDarkActive = Color(0xFF2D3748);
  static const Color buttonTextDarkDisabled = Color(0xFF718096);

  // Extended Color Palette
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE5E5E5);
  static const Color neutral300 = Color(0xFFD1D1D1);
  static const Color neutral400 = Color(0xFF9B9B9B);
  static const Color neutral500 = Color(0xFF6B6B6B);
  static const Color neutral600 = Color(0xFF505050);
  static const Color neutral700 = Color(0xFF404040);
  static const Color neutral900 = Color(0xFF1d2129);
  static const Color neutral50 = Color(0xFFFAFAFA);
  
  static const Color secondary50 = Color(0xFFF5F0E8);
  static const Color secondary100 = Color(0xFFE8D4B8);
  static const Color secondary200 = Color(0xFFDCC7A0);
  static const Color secondary600 = Color(0xFF606770);
  static const Color secondary700 = Color(0xFF654321);
  static const Color secondary800 = Color(0xFF4A2C17);
  
  static const Color primary50 = Color(0xFFF5F5F5);
  static const Color primary100 = Color(0xFFE5E5E5);
  static const Color primary200 = Color(0xFFD1D1D1);
  static const Color primary500 = primaryBlue;
  static const Color primary600 = Color(0xFF1A1A1A);
  static const Color primary700 = Color(0xFF0F0F0F);
  static const Color primary800 = Color(0xFF050505);
  
  static const Color success50 = Color(0xFFF5F5F5);
  static const Color success200 = Color(0xFFD1D1D1);
  static const Color success500 = Color(0xFF2e7d32);
  static const Color success600 = Color(0xFF1A1A1A);
  static const Color success700 = Color(0xFF0F0F0F);
  
  static const Color warning500 = Color(0xFFe59a4c);
  static const Color error500 = Color(0xFF8B4A4A);

  // Opacity Variants
  static Color primaryWithOpacity(double opacity) => primary.withValues(alpha: opacity);
  static Color secondaryWithOpacity(double opacity) => secondary.withValues(alpha: opacity);
  static Color accentWithOpacity(double opacity) => accent.withValues(alpha: opacity);
  static Color textPrimaryWithOpacity(double opacity) => textPrimary.withValues(alpha: opacity);
  static Color textSecondaryWithOpacity(double opacity) => textSecondary.withValues(alpha: opacity);
}
