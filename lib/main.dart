import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tubes1/db/db_helper.dart';
import 'package:tubes1/services/notification_services.dart';
import 'package:tubes1/services/theme_services.dart';
import 'package:tubes1/ui/widgets/home_page.dart';
import 'package:tubes1/ui/widgets/signin.dart';
import 'package:tubes1/ui/widgets/splash_screen.dart';
import 'package:tubes1/ui/widgets/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHelper.initDb();
  NotifyHelper().initializeNotification();
  const String googleSignInClientId =
      "978452785483-jadpq0d2sad43ctn0qdnsri8qb7a1a2m.apps.googleusercontent.com";

  // Initialize GoogleSignIn with the client ID
  GoogleSignIn googleSignIn = GoogleSignIn(clientId: googleSignInClientId);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCrTkKv9T2f7oz8xsaaa0YHKRfeL8u2SW4",
      authDomain: "flutter-auth-85e17.firebaseapp.com",
      projectId: "tubes-85e17",
      messagingSenderId: "978452785483",
      appId: "1:978452785483:android:363cd152af5aa414f520ce",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/sign': (context) => SignIn(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
