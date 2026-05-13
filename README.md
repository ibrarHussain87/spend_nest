# SpendNest

Expense tracker built with Flutter, Firebase Auth (anonymous), and Cloud Firestore.

## Open in your IDE

Open this directory as the project root (the folder that contains `pubspec.yaml`).

## One-time setup

1. Install [Flutter](https://docs.flutter.dev/get-started/install) and run `flutter doctor` until your target platforms are ready.
2. From this folder, configure Firebase for all platforms you use:

   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

   That refreshes `lib/firebase_options.dart` and adds `google-services.json` / `GoogleService-Info.plist` as needed.

3. In the Firebase console, enable **Authentication → Anonymous** and create a **Firestore** database. Deploy the rules from `firestore.rules` (or paste them in the Rules editor).

## Run

```bash
flutter pub get
flutter run
```

Use the **SpendNest (debug)** launch configuration if you use VS Code or Cursor.
