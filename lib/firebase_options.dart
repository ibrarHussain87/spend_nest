// GENERATED PLACEHOLDER — run in project root:
//   dart pub global activate flutterfire_cli
//   flutterfire configure
// That overwrites this file with real keys for each platform.
//
// Until then, replace the placeholder values below from the Firebase console:
// Project settings → Your apps → SDK setup and configuration.

import "package:firebase_core/firebase_core.dart" show FirebaseOptions;
import "package:flutter/foundation.dart"
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          "SpendNest: add this platform via flutterfire configure.",
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "REPLACE_ME",
    appId: "1:000000000000:web:0000000000000000000000",
    messagingSenderId: "000000000000",
    projectId: "your-project-id",
    authDomain: "your-project-id.firebaseapp.com",
    storageBucket: "your-project-id.appspot.com",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "REPLACE_ME",
    appId: "1:000000000000:android:0000000000000000000000",
    messagingSenderId: "000000000000",
    projectId: "your-project-id",
    storageBucket: "your-project-id.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "REPLACE_ME",
    appId: "1:000000000000:ios:0000000000000000000000",
    messagingSenderId: "000000000000",
    projectId: "your-project-id",
    storageBucket: "your-project-id.appspot.com",
    iosBundleId: "com.spendnest.spend_nest",
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "REPLACE_ME",
    appId: "1:000000000000:ios:0000000000000000000000",
    messagingSenderId: "000000000000",
    projectId: "your-project-id",
    storageBucket: "your-project-id.appspot.com",
    iosBundleId: "com.spendnest.spend_nest",
  );
}
