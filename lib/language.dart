import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_eng.dart';
import 'login_nep.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background_image1.JPG'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              // ignore: sort_child_properties_last
              child: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 24,
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.red,
              ),
            ),
            Image.asset(
              'images/logo.png',
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
                  Colors.grey;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginEng(),
                    ),
                  );
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
                  backgroundColor: Colors.grey;
                  duration: 2000;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginNep(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
