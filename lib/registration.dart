import 'dart:io';

import 'package:flutter/material.dart';
import 'package:khatakapi/otp_Eng.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/logo.png',
          width: 100,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OtpEng(),
              ),
            );
          },
        ),
        actions: <Widget>[
          Padding(
            padding:
            const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                exit(0);
               },
              child: const Icon(
                Icons.cancel,
                size: 26.0,
                color: Colors.red,
               ),
             ),
           ),
         ],
        
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image2.JPG'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topLeft,
            ),
          ],
        ),
      ),
    );
  }
}
