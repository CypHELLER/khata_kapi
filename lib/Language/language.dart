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
            builder: (context) => Home(),
          ),
        );
      } else if (check == "0") {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginEng(),
          ),
        );
      } else if (check == "1") {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginNep(),
          ),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginEng(),
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
              height: 300,
              width: 200,
              fit: BoxFit.fitWidth,
            ),
            Container(
              padding: const EdgeInsets.only(left: 50, top: 250),
              child: const Text(
                'भाषा छनोट गर्नुहोस।\nPlease Choose your language',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 150, top: 370),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'English',
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
            Container(
              padding: const EdgeInsets.only(left: 155, top: 450),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'नेपाली',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                onPressed: () {
                  checkIfLoggedIn();
                  Colors.grey;
                  check = "1";
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
