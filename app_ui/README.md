# Fekra House · بيت الفكرة

Bilingual document scanning & organizing app.
Structure: **Feature-first · Cubit · GetIt** (see `Flutter_Developer_Structure_Guide_AR.pdf`).

## Requirements

- Flutter **3.27+** (uses `Color.withValues`) with Dart **3.3+**.
- Internet on first run: `google_fonts` downloads Outfit / Cairo at runtime.
- Platform folders: this repo only tracks `lib/` and `test/`. Generate the platform
  folders once (it does not touch `lib/`):

  ```bash
  flutter create . --project-name fekra_house
  ```

## Setup & run

```bash
flutter pub get
flutter run
```

Keep `pubspec.lock` committed so everyone builds with the same package versions.
No environment config is needed yet (all data is mocked). When an API is added, put
the base URL in `config/environment/env.dart` and pass it with `--dart-define`; never
commit keys or credentials.

## Before every delivery (review checklist)

```bash
dart format .
flutter analyze   # must report: No issues found!
flutter test
```

Tests mirror `lib/`: `test/core/...` and `test/features/<feature>/{data,domain,presentation}/...`.
They cover validators, model mapping, repository error handling (Exception → Failure),
use cases, and every Cubit's loading / success / empty / failure states.

## Structure

```
lib/
├── main.dart                     # binding → setupServiceLocator() → runApp
├── app.dart                      # MaterialApp: theme + routes
├── config/
│   ├── routes/                   # app_routes.dart (names), app_router.dart (table + BlocProviders)
│   └── theme/                    # app_colors, app_text_styles, app_theme
├── core/
│   ├── errors/                   # exceptions.dart, failures.dart, failure_guard.dart
│   ├── use_case/use_case.dart    # UseCase<T, P> → Future<Either<Failure, T>>, NoParams
│   ├── services/locator/         # service_locator.dart (GetIt wiring)
│   ├── utils/validators.dart     # form-format checks (name, phone, password)
│   └── widgets/                  # AppCard, GradientButton, Logo, SearchBox, FolderTag,
│                                 # LoadingIndicator, ErrorView, EmptyView
└── features/
    ├── auth/        domain · data · presentation (LoginCubit, RegisterCubit, OtpCubit; login/register/otp screens)
    ├── documents/   domain · data · presentation (HistoryCubit, history screen, FileTile)
    ├── folders/     domain · data · presentation (FoldersCubit, folders screen)
    ├── home/        presentation only — HomeCubit composes auth + documents use cases
    ├── profile/     presentation only — ProfileCubit reuses auth's GetCurrentUser
    ├── scan/        presentation only (static UI; add domain/data when camera/OCR lands)
    ├── shell/       presentation only — main_shell_screen.dart (bottom nav)
    └── splash/      presentation only
```

Each feature follows the same template, creating only the folders it needs:

```
feature/
├── data/          data_sources/ · models/ (fromJson/toJson/toEntity) · repositories/ (*_impl)
├── domain/        entities/ · repositories/ (contracts) · use_cases/ (one per file)
└── presentation/  view_model/ (*_cubit, *_state) · views/screens/ · views/widgets/
```

## Rules

- Dependencies: `presentation → domain ← data`. Domain is pure Dart (no Flutter, no JSON).
- Request flow: Screen → Cubit → UseCase → Repository contract → RepositoryImpl → DataSource.
  Errors: Exception → Failure (at the repository, via `guardFailure`) → Cubit → State → Screen.
- Only `service_locator.dart` and `app_router.dart` touch GetIt; everything else gets its
  dependencies through the constructor.
- Screens show every state the flow needs: loading, failure (with retry), empty, success.
- Data sources / repositories / use cases are lazy singletons; Cubits are factories, created
  by a `BlocProvider` next to their screen (which also closes them).
- Features may use another feature's **domain** (entities, use cases). Two shared document
  widgets (`FileTile`, `category_style`) are also reused by home/folders; never import another
  feature's screens, Cubits or data layer.

## Going live

Replace `*_mock_data_source.dart` / `auth_local_data_source.dart` with remote data sources
(add `core/services/api/dio_client.dart` + `config/environment/env.dart` at that point) and
update the matching `*_repository_impl.dart`. Domain and presentation stay unchanged.
