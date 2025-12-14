# Contributing to OneStep

Thank you for your interest in contributing to OneStep! This document provides guidelines and instructions for contributing.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Branching Strategy](#branching-strategy)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)
- [Code Style](#code-style)
- [Testing](#testing)

## 📜 Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for everyone.

## 🚀 Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/onestep.git
   cd onestep
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/AffanShaikhsurab/onestep.git
   ```
4. **Set up the development environment** (see [README.md](README.md))

## 🔄 Development Workflow

1. **Sync with upstream** before starting work:
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **Create a feature branch** (see [Branching Strategy](#branching-strategy))

3. **Make your changes** with proper commits (see [Commit Messages](#commit-messages))

4. **Push to your fork** and create a Pull Request

## 🌿 Branching Strategy

We follow a **feature branch workflow**. All development happens in dedicated branches.

### Branch Naming Convention

| Type | Pattern | Example |
|------|---------|---------|
| Feature | `feat/<feature-name>` | `feat/habit-reminders` |
| Bug Fix | `fix/<bug-description>` | `fix/login-crash` |
| Refactor | `refactor/<description>` | `refactor/auth-service` |
| Documentation | `docs/<description>` | `docs/api-reference` |
| Hotfix | `hotfix/<description>` | `hotfix/critical-auth-bug` |

### Branch Rules

- ✅ **Never commit directly to `main`**
- ✅ Create a new branch for every feature or fix
- ✅ Keep branches focused on a single concern
- ✅ Delete branches after merging
- ❌ Don't work on multiple unrelated features in one branch

### Example Workflow

```bash
# Start a new feature
git checkout main
git pull upstream main
git checkout -b feat/habit-notifications

# Work on your feature...
# Make commits...

# Push and create PR
git push origin feat/habit-notifications
```

## 💬 Commit Messages

We follow the **Conventional Commits** specification.

### Format

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation changes |
| `style` | Code style changes (formatting, semicolons, etc.) |
| `refactor` | Code refactoring (no feature or bug fix) |
| `perf` | Performance improvements |
| `test` | Adding or updating tests |
| `chore` | Maintenance tasks |

### Scopes (Optional)

Use the feature/module name: `auth`, `habits`, `tracking`, `ui`, `core`, etc.

### Examples

```bash
# Good commits ✅
feat(auth): add Google OAuth login
fix(habits): resolve date picker crash on iOS
docs: update installation instructions
refactor(core): simplify service locator setup
test(tracking): add unit tests for streak calculation

# Bad commits ❌
fixed stuff
update
WIP
asdfgh
```

### Commit Best Practices

- ✅ Write in imperative mood: "add feature" not "added feature"
- ✅ Keep subject line under 72 characters
- ✅ Explain **why** in the body, not just **what**
- ✅ One logical change per commit
- ❌ Don't commit generated files, secrets, or large binaries

## 🔀 Pull Request Process

### Before Creating a PR

1. ✅ Ensure your code follows our [Code Style](#code-style)
2. ✅ Run all tests: `flutter test`
3. ✅ Run the analyzer: `flutter analyze`
4. ✅ Update documentation if needed
5. ✅ Rebase on latest `main` if needed

### PR Title

Follow the same format as commit messages:
```
feat(scope): description of the change
```

### PR Description Template

```markdown
## Summary
Brief description of what this PR does.

## Changes
- Change 1
- Change 2

## Testing
How to test these changes.

## Screenshots (if applicable)
Add screenshots for UI changes.

## Checklist
- [ ] Code follows project style guidelines
- [ ] Tests pass locally
- [ ] Documentation updated (if needed)
- [ ] No secrets or sensitive data included
```

### Review Process

1. At least one approval required before merging
2. All CI checks must pass
3. Resolve all review comments
4. Squash and merge preferred for clean history

## 🎨 Code Style

### Dart/Flutter Guidelines

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `flutter_lints` rules (configured in `analysis_options.yaml`)
- Maximum line length: 80 characters
- Use trailing commas for better formatting

### File Organization

```dart
// 1. File header comment
/// Feature: feature_name
/// Summary: Brief description
/// Author: your_name

// 2. Imports (sorted)
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../relative_import.dart';

// 3. Part directives (if any)
part 'file.g.dart';

// 4. Constants
const kDefaultPadding = 16.0;

// 5. Classes/Functions
class MyWidget extends StatelessWidget {
  // ...
}
```

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Files | `snake_case` | `habit_repository.dart` |
| Classes | `PascalCase` | `HabitRepository` |
| Variables | `camelCase` | `habitList` |
| Constants | `camelCase` with `k` prefix | `kDefaultPadding` |
| Private | `_` prefix | `_privateMethod()` |

## 🧪 Testing

### Test File Naming

```
test/
├── feature_name/
│   ├── bloc/
│   │   └── feature_bloc_test.dart
│   ├── repository/
│   │   └── feature_repository_test.dart
│   └── widgets/
│       └── feature_widget_test.dart
```

### Writing Tests

```dart
void main() {
  group('FeatureBloc', () {
    late FeatureBloc bloc;
    
    setUp(() {
      bloc = FeatureBloc();
    });
    
    tearDown(() {
      bloc.close();
    });
    
    test('initial state is correct', () {
      expect(bloc.state, equals(FeatureInitial()));
    });
    
    blocTest<FeatureBloc, FeatureState>(
      'emits [Loading, Loaded] when data is fetched',
      build: () => bloc,
      act: (bloc) => bloc.add(FetchData()),
      expect: () => [FeatureLoading(), FeatureLoaded()],
    );
  });
}
```

### Test Coverage

- Aim for >80% coverage on business logic
- All BLoCs should have comprehensive tests
- Repository methods should be tested with mocks

---

## ❓ Questions?

If you have questions, feel free to:
- Open a [GitHub Discussion](https://github.com/AffanShaikhsurab/onestep/discussions)
- Create an issue with the `question` label

Thank you for contributing to OneStep! 🎉
