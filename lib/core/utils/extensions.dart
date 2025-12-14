/// Useful extension methods for common operations
library extensions;

import 'package:flutter/material.dart';

// String extensions
extension StringExtensions on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get titleCase {
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  bool get isEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  bool get isUrl {
    return RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'
    ).hasMatch(this);
  }

  String get cleanWhitespace {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  String truncate(int maxLength, [String suffix = '...']) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }
}

// DateTime extensions
extension DateTimeExtensions on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  String get friendlyDate {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';
    if (isTomorrow) return 'Tomorrow';
    
    final now = DateTime.now();
    final difference = now.difference(this).inDays;
    
    if (difference < 7 && difference > 0) {
      const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
      return weekdays[weekday - 1];
    }
    
    return '$day/$month/$year';
  }
}

// List extensions
extension ListExtensions<T> on List<T> {
  T? get randomElement {
    if (isEmpty) return null;
    return this[(DateTime.now().millisecondsSinceEpoch % length)];
  }

  bool get hasDuplicates {
    return length != toSet().length;
  }

  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    final map = <K, List<T>>{};
    for (final item in this) {
      final key = keyFunction(item);
      map.putIfAbsent(key, () => []).add(item);
    }
    return map;
  }

  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, (i + size > length) ? length : i + size));
    }
    return chunks;
  }
}

// BuildContext extensions
extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  NavigatorState get navigator => Navigator.of(this);
  
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  
  Future<T?> push<T>(Route<T> route) => Navigator.of(this).push(route);
  
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);
  
  Future<T?> pushReplacement<T, TO>(Route<T> newRoute, {TO? result}) =>
      Navigator.of(this).pushReplacement(newRoute, result: result);
  
  Future<T?> pushReplacementNamed<T, TO>(String routeName, {TO? result, Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName, result: result, arguments: arguments);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  
  void showSnackBar(SnackBar snackBar) => ScaffoldMessenger.of(this).showSnackBar(snackBar);
  
  void hideCurrentSnackBar() => ScaffoldMessenger.of(this).hideCurrentSnackBar();

  void unfocus() => FocusScope.of(this).unfocus();
  
  void requestFocus(FocusNode focusNode) => FocusScope.of(this).requestFocus(focusNode);

  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;
}

// Duration extensions
extension DurationExtensions on Duration {
  String get humanReadable {
    if (inDays > 0) {
      return '$inDays day${inDays == 1 ? '' : 's'}';
    } else if (inHours > 0) {
      return '$inHours hour${inHours == 1 ? '' : 's'}';
    } else if (inMinutes > 0) {
      return '$inMinutes minute${inMinutes == 1 ? '' : 's'}';
    } else {
      return '$inSeconds second${inSeconds == 1 ? '' : 's'}';
    }
  }
}

// Color extensions
extension ColorExtensions on Color {
  Color get contrastingColor {
    final luminance = computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}
