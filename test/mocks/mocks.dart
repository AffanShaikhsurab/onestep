// Mock classes for testing
// Generate mocks with: dart run build_runner build --delete-conflicting-outputs

import 'package:mockito/annotations.dart';
import 'package:onestep/core/services/auth_service.dart';
import 'package:onestep/features/habit_creation/data/repository/habit_repository.dart';
import 'package:onestep/features/identity_onboarding/data/repository/identity_repository.dart';

@GenerateMocks([
  AuthService,
  HabitRepository,
  IdentityRepository,
])
void main() {}
