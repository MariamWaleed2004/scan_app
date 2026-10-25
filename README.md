# Scan App

Flutter Android and iOS application in `app_ui/`.

[Download the latest APK and unsigned IPA](https://github.com/MariamWaleed2004/scan_app/releases/latest)
| [Build status](https://github.com/MariamWaleed2004/scan_app/actions/workflows/android-release.yml)

## Automatic APK and IPA releases

Every push to `main` runs analysis, tests, an Android release build on Linux,
and an unsigned iOS device build on macOS. After both builds succeed, a GitHub
Release named `build-<run number>` contains `scan-app.apk`,
`scan-app-unsigned.ipa`, and SHA-256 checksums for both files.
Download them from **Releases** in the repository sidebar, then expand **Assets**.

Pull requests run the same builds and upload the APK and IPA as Actions artifacts,
without publishing a release. You can also run **Actions → Android APK and
iOS IPA Release → Run workflow** manually. Pushing a tag such as `v1.0.0` publishes a
release under that tag instead. Re-running a workflow replaces its APK assets.

The workflow uses the built-in `GITHUB_TOKEN` with write permission limited to
the release job; no personal access token or repository secret is required.
Repository or organization policy must allow GitHub Actions to write contents.

## iPhone installation with Sideloadly

The IPA is **unsigned**: it cannot be installed directly or submitted to the
App Store. No Apple certificate, provisioning profile, or Apple account secret
is used by CI. The workflow builds `Runner.app` for a physical iOS device with
`flutter build ios --release --no-codesign`, then packages it inside the
standard `Payload/Runner.app` IPA layout, preserving symbolic links. It checks
the arm64 executable and ZIP integrity before uploading.

Download `scan-app-unsigned.ipa`, select it in Sideloadly, and use Sideloadly
to sign and install it on your connected iPhone with your Apple account.
Signing and installation on a real device are separate from CI verification.

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
