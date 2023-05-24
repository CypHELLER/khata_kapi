import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Dashbord/home.dart';
import '../Login/login_eng.dart';
import '../Login/login_nep.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => LanguageState();
}

class LanguageState extends State<Language> {
  // ignore: constant_identifier_names
  static const String KEYLOGIN = "login";
  String check = "";
  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
  }

  void checkIfLoggedIn() async {
    var prefs = await SharedPreferences.getInstance();
    var isLoggedIn = prefs.getBool(KEYLOGIN);

    if (isLoggedIn != null) {
      if (isLoggedIn) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      } else if (check == "0") {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginEng(),
          ),
        );
      } else if (check == "1") {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginNep(),
          ),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginEng(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background_image1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Image.asset(
              alignment: Alignment.center,
              'assets/images/logo.png',
              height: 400,
              width: 200,
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: const EdgeInsets.only(left: 150, top: 370),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                onPressed: () {
                  checkIfLoggedIn();
                  check = "0";
                  Colors.grey;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
