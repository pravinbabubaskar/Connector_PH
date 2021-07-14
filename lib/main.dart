import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectorph/screens/welcome_screen.dart';
import 'package:connectorph/screens/login_screen.dart';
import 'package:connectorph/screens/registration_screen.dart';
import 'package:connectorph/screens/home_screen.dart';
import 'package:connectorph/screens/bot_screen.dart';
import 'package:connectorph/Screens/stories_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(connectorph());
}

class connectorph extends StatelessWidget {
  String s = (FirebaseAuth.instance.currentUser != null) ? 'home' : 'welcome';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: s,
      routes: {
        'welcome': (context) => WelcomeScreen(),
        'login': (context) => LoginScreen(),
        'register': (context) => RegistrationScreen(),
        'home': (context) => ChatScreen(),
        'bot': (context) => BotScreen(),
        'stories': (context) => StoriesScreen(),
      },
    );
  }
}
