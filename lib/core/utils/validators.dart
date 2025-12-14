/// Validation functions for form fields and user input
library validators;

class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
    }
    
    return null;
  }

  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? minLength(String? value, int minLength, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters long';
    }
    
    return null;
  }

  static String? maxLength(String? value, int maxLength, [String? fieldName]) {
    if (value != null && value.length > maxLength) {
      return '${fieldName ?? 'This field'} must not exceed $maxLength characters';
    }
    return null;
  }

  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
    if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[\s\-\(\)]'), ''))) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }
    
    final urlRegex = RegExp(r'^https?:\/\/[^\s/$.?#].[^\s]*$');
    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    
    return null;
  }

  static String? number(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }
    
    return null;
  }

  static String? integer(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (int.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a valid integer';
    }
    
    return null;
  }

  static String? range(String? value, double min, double max, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    final number = double.tryParse(value);
    if (number == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }
    
    if (number < min || number > max) {
      return '${fieldName ?? 'This field'} must be between $min and $max';
    }
    
    return null;
  }

  static String? confirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  static String? date(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }
    
    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return 'Please enter a valid date';
    }
  }

  static String? age(String? value, {int minAge = 0, int maxAge = 150}) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    
    final age = int.tryParse(value);
    if (age == null) {
      return 'Age must be a valid number';
    }
    
    if (age < minAge || age > maxAge) {
      return 'Age must be between $minAge and $maxAge';
    }
    
    return null;
  }

  static String? identityName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Identity name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Identity name must be at least 2 characters long';
    }
    
    if (value.trim().length > 50) {
      return 'Identity name must not exceed 50 characters';
    }
    
    return null;
  }

  static String? habitName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Habit name is required';
    }
    
    if (value.trim().length < 3) {
      return 'Habit name must be at least 3 characters long';
    }
    
    if (value.trim().length > 100) {
      return 'Habit name must not exceed 100 characters';
    }
    
    return null;
  }

  static String? implementationIntention(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Implementation intention is required';
    }
    
    if (value.trim().length < 10) {
      return 'Implementation intention must be at least 10 characters long';
    }
    
    if (value.trim().length > 500) {
      return 'Implementation intention must not exceed 500 characters';
    }
    
    return null;
  }

  static String? combine(List<String? Function()> validators) {
    for (final validator in validators) {
      final result = validator();
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
