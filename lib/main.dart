import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";

import "firebase_options.dart";
import "screens/home_screen.dart";
import "services/expense_repository.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }

  runApp(const SpendNestApp());
}

class SpendNestApp extends StatelessWidget {
  const SpendNestApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = ColorScheme.fromSeed(
      seedColor: const Color(0xFF2E7D32),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: "SpendNest",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: seed,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const _Root(),
    );
  }
}

class _Root extends StatelessWidget {
  const _Root();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final user = snapshot.data;
        if (user == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Signing you in…"),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () =>
                        FirebaseAuth.instance.signInAnonymously(),
                    child: const Text("Retry anonymous sign-in"),
                  ),
                ],
              ),
            ),
          );
        }

        final repo = ExpenseRepository(user.uid);
        final label = user.isAnonymous ? "Guest" : (user.email ?? "Signed in");

        return HomeScreen(
          repository: repo,
          displayName: label,
        );
      },
    );
  }
}
