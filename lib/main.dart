/// Main entry point for the OneStep application
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';
import 'features/authentication/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: ".env");
  
  // Initialize service locator (dependency injection)
  await ServiceLocator.init();
  
  // Set up BLoC observer for debugging
  Bloc.observer = AppBlocObserver();
  
  runApp(const OneStepApp());
}

/// Main application widget
class OneStepApp extends StatelessWidget {
  const OneStepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(sl<AuthService>()),
      child: MaterialApp(
        title: 'OneStep',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthWrapper(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          // Additional routes will be added as features are migrated
        },
      ),
    );
  }
}
