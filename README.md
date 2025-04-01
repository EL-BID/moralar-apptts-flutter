[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=EL-BID_moralar-apptts-flutter&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=EL-BID_moralar-apptts-flutter)

# moralar_tts

This is the app that the field agent will have installed to manage end user statuses and check their progress.

### Moralar Project
Here are the repositories used in the project:

- Moralar App for end user - https://github.com/EL-BID/moralar-appusuario-flutter
- Morar App for Field Agent (TTS) - https://github.com/EL-BID/moralar-apptts-flutter
- Moralar Web App for Admins, Field Agents and Public managers - https://github.com/EL-BID/moralar-admin
- Web Server for All applications - https://github.com/EL-BID/moralar-api

## Getting Started

### Requirements
- [Flutter](https://docs.flutter.dev/get-started/install)
- [Moralar Widgets](https://github.com/EL-BID/moralar-widgets)
- Mega flutter package (Not available online)
- [Android emulator](https://developer.android.com/studio/run/emulator)

## Setup
- Run `flutter pub get` to fetch packages.
- Moralar widgets and Mega Flutter project folders must be siblings to moralar_tts like this:
  - Root Folder/
    - Moralar Widgets/
    - Mega Flutter/
    - Moralar TTS/
- Run an android emulator (currently, iOS development is not supported, although it is possible to run on dev mode after you fix the issues inherent to running in iOS).
- run `flutter run` and it will search for the emulators to run. If you have only one it will be automatically selected.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
