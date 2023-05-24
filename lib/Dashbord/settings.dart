import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Language/language.dart';
import 'editprofile.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;

  const SettingsPage({required this.isDarkMode});
  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  //bool _isDarkMode = false;
  String uID = '';
  @override
  void initState() {
    super.initState();
    uID = FirebaseAuth.instance.currentUser!.phoneNumber.toString();
    //_isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
                title: '',
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                children: <Widget>[
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
        onPressed: () async {},
      ),
      onTap: () async {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uID)
            .delete()
            .then((value) {
          print('Document deleted successfully');
        }).catchError((error) {
          print('Failed to delete document: $error');
        });
        var pref = await SharedPreferences.getInstance();
        pref.setBool(LanguageState.KEYLOGIN, false);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => exit(0),
            ));
        ScaffoldMessenger.of(context).showSnackBar(
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
        );
      });

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
