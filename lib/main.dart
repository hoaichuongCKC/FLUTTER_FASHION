import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fashion/app/config/theme.dart';
import 'app/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemUiOverlay.top;
    return MaterialApp.router(
      theme: appTheme,
      routerConfig: AppRoutes.router,
      debugShowCheckedModeBanner: false,
      title: 'App Fashion',
    );
  }
}
