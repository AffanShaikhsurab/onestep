# OneStep Feature Branch Migration Plan

This document outlines the order and structure for migrating features from the legacy codebase to the clean repository.

## Branch Migration Order

The features should be migrated in this specific order due to dependencies:

### Phase 1: Core Foundation
These must be added first as all features depend on them.

| Order | Branch Name | Description | Dependencies |
|-------|-------------|-------------|--------------|
| 1 | `feat/core-foundation` | Core utilities, theme, constants, interfaces | None |
| 2 | `feat/core-services` | Appwrite, database, storage services | core-foundation |

### Phase 2: Authentication
User authentication must work before any user-specific features.

| Order | Branch Name | Description | Dependencies |
|-------|-------------|-------------|--------------|
| 3 | `feat/authentication` | Login, signup, OAuth, session management | core-services |

### Phase 3: Identity System
The identity system is central to the app's unique value proposition.

| Order | Branch Name | Description | Dependencies |
|-------|-------------|-------------|--------------|
| 4 | `feat/identity-onboarding` | Identity setup flow for new users | authentication |
| 5 | `feat/identity-scorecard` | Identity score tracking and display | identity-onboarding |

### Phase 4: Habit Features
Core habit functionality.

| Order | Branch Name | Description | Dependencies |
|-------|-------------|-------------|--------------|
| 6 | `feat/habit-creation` | Create and edit habits | identity-scorecard |
| 7 | `feat/habit-tracking` | Track daily habit completion | habit-creation |
| 8 | `feat/habit-stacking` | Link habits together | habit-tracking |

### Phase 5: Additional Features

| Order | Branch Name | Description | Dependencies |
|-------|-------------|-------------|--------------|
| 9 | `feat/dashboard` | Main dashboard UI | habit-tracking |
| 10 | `feat/profile` | User profile management | authentication |
| 11 | `feat/identity-evidence-ledger` | Evidence tracking for identity | identity-scorecard |
| 12 | `feat/micro-affirmations` | Identity affirmation system | identity-scorecard |

---

## Directory Structure per Feature

Each feature should follow this structure:

```
lib/features/<feature_name>/
├── data/
│   ├── models/           # Data models
│   ├── repositories/     # Repository implementations
│   └── sources/          # Data sources (local/remote)
├── state/
│   ├── bloc/             # BLoC classes
│   └── events_states/    # Events and states
└── ui/
    ├── screens/          # Full screens
    ├── widgets/          # Feature-specific widgets
    └── pages/            # Page compositions
```

---

## Migration Checklist for Each Feature

Before creating a PR for any feature branch:

- [ ] Remove all hardcoded API keys or secrets
- [ ] Remove debug print statements
- [ ] Remove commented-out code
- [ ] Ensure proper error handling
- [ ] Add necessary exports
- [ ] Verify imports use relative paths
- [ ] Check for unused imports
- [ ] Run `flutter analyze`
- [ ] Add basic tests if time permits

---

## How to Migrate a Feature

```bash
# 1. Start from main
git checkout main
git pull origin main

# 2. Create feature branch
git checkout -b feat/<feature-name>

# 3. Copy necessary files from old repo (manually review each file!)

# 4. Clean the code:
#    - Remove secrets
#    - Remove debug code
#    - Fix imports

# 5. Test locally
flutter analyze
flutter test

# 6. Commit with proper message
git add .
git commit -m "feat(<scope>): add <feature description>"

# 7. Push and create PR
git push origin feat/<feature-name>
```

---

## Next Steps

1. Start with `feat/core-foundation`
2. After merge, proceed with `feat/core-services`
3. Continue in order...

Would you like me to start migrating the first feature?
