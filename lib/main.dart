import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:khatakapi/home.dart';
import 'package:khatakapi/language.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
   );
  
   runApp(const MyApp());
  }


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/logo.png'),
        duration: 2100,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: const Color.fromARGB(255, 142, 234, 125),
        nextScreen: const Language(),
      ),
    );
  }
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
