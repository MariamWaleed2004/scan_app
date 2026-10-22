# Scan App

Flutter Android application in `app_ui/`.

[Download the latest APK](https://github.com/MariamWaleed2004/scan_app/releases/latest)
| [Build status](https://github.com/MariamWaleed2004/scan_app/actions/workflows/android-release.yml)

## Automatic APK releases

Every push to `main` runs analysis, tests, and a release APK build. A successful
build publishes a GitHub Release named `build-<run number>` containing
`scan-app.apk` and its SHA-256 checksum. Download the APK from **Releases** in
the repository sidebar, then expand **Assets**.

Pull requests run the same checks and upload the APK as an Actions artifact,
without publishing a release. You can also run **Actions → Android APK and
Release → Run workflow** manually. Pushing a tag such as `v1.0.0` publishes a
release under that tag instead. Re-running a workflow replaces its APK assets.

The workflow uses the built-in `GITHUB_TOKEN` with write permission limited to
the release job; no personal access token or repository secret is required.
Repository or organization policy must allow GitHub Actions to write contents.

## Local checks

Use Flutter **3.44.0** (Dart **3.12.0**) and Java **17**:

```sh
cd app_ui
flutter pub get
flutter analyze --no-fatal-infos
flutter test
flutter build apk --release
```

The APK uses the existing **debug signing key**. It is suitable for test
distribution; publishing to Google Play or reliably upgrading between CI builds
requires a persistent private release keystore configured through GitHub Secrets.
