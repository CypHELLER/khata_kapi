import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Dashbord/settings.dart';
import 'Language/language.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
   );
  
   runApp(const MyApp());
  }

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
 var mode = SettingsPageState();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mode.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/logo.png'),
        nextScreen: const Language(),
        duration: 2100,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color.fromARGB(255, 142, 234, 125),
        splashIconSize: 100,
        
      ),
    );
  }
}
