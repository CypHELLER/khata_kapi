import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'language.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  }


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates:const [
        GlobalMaterialLocalizations.delegate,
       ],
       supportedLocales: const [
        Locale('en'),
        Locale('ne'),
        ],
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: Colors.cyan,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/logo.png'),
        duration: 2100,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Color.fromARGB(255, 142, 234, 125),
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
