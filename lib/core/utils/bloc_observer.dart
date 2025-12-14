/// BLoC observer for debugging and monitoring state changes
library bloc_observer;

import 'dart:developer' as developer;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../env/app_config.dart';

/// Custom BLoC observer for logging state changes
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (AppConfig.debugMode) {
      developer.log('🟢 Bloc Created: ${bloc.runtimeType}', name: 'BlocObserver');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (AppConfig.debugMode) {
      developer.log('🔵 Event: ${bloc.runtimeType} - $event', name: 'BlocObserver');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (AppConfig.debugMode) {
      developer.log('🟡 State Change: ${bloc.runtimeType}', name: 'BlocObserver');
      developer.log('  Current: ${change.currentState}', name: 'BlocObserver');
      developer.log('  Next: ${change.nextState}', name: 'BlocObserver');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (AppConfig.debugMode) {
      developer.log('🟠 Transition: ${bloc.runtimeType}', name: 'BlocObserver');
      developer.log('  Event: ${transition.event}', name: 'BlocObserver');
      developer.log('  Current: ${transition.currentState}', name: 'BlocObserver');
      developer.log('  Next: ${transition.nextState}', name: 'BlocObserver');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    developer.log(
      '🔴 Error in ${bloc.runtimeType}: $error',
      name: 'BlocObserver',
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (AppConfig.debugMode) {
      developer.log('🔴 Bloc Closed: ${bloc.runtimeType}', name: 'BlocObserver');
    }
  }
}
