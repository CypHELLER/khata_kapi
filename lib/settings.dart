import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
          backgroundColor: Color.fromARGB(255, 148, 121, 163),
        ),
        body: SingleChildScrollView(
          child: Column(
            
           ),
         ),
     );
  }
}