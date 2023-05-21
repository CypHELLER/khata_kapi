import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Language/language.dart';
import 'editprofile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late bool isDarkMode = false;
  // ignore: constant_identifier_names
  static const String MODE = 'isDarkMode';

  @override
  void initState() {
    super.initState();
    getThemeMode();
  }

  Future<void> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool(MODE) ?? false;
    });
  }

  Future<void> setThemeMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(MODE, value);
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Image.asset(
          "assets/images/logo.png",
          width: 80,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: const Color.fromARGB(255, 148, 121, 163),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            SettingsGroup(
                title: 'Settings',
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.light_mode,
                          color: Colors.blue,
                        ),
                        onPressed: () {},
                      ),
                      const Text(
                        'Switch Mode',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          setThemeMode(value);
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  editProfile(),
                  const SizedBox(
                    height: 15,
                  ),
                  logOut(),
                  const SizedBox(
                    height: 15,
                  ),
                  deleteAccount(),
                ]),
          ],
        ),
      ),
    );
  }

  logOut() => SimpleSettingsTile(
      title: 'Logout',
      subtitle: '',
      leading: IconButton(
        icon: const Icon(
          Icons.logout,
          color: Color.fromARGB(255, 12, 64, 106),
        ),
        onPressed: () {},
      ),
      onTap: () async {
        var pref = await SharedPreferences.getInstance();
        pref.setBool(LanguageState.KEYLOGIN, false);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => exit(0),
          ),
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Logging Out'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.grey[700],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: 280.0,
          ),
        );
      });

  deleteAccount() => SimpleSettingsTile(
        title: 'Delete Account',
        subtitle: '',
        leading: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {},
        ),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Account Deleted'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.grey[700],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: 280.0,
          ),
        ),
      );

  editProfile() => SimpleSettingsTile(
      title: 'Edit Profile',
      subtitle: '',
      leading: IconButton(
        icon: const Icon(
          Icons.edit,
          color: Colors.green,
        ),
        onPressed: () {},
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditProfile(),
          ),
        );
      });
}
