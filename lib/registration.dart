import 'dart:io';
import 'package:flutter/material.dart';
import 'home.dart';

const List<String> list = <String>[
  'Gender',
  'Male',
  'Female',
  'Other',
  'Do not want to specify'
];

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90)),
                color: Colors.amber,
                gradient: LinearGradient(
                  colors: [
                    (Color.fromARGB(255, 148, 121, 163)),
                    Color.fromARGB(255, 24, 210, 213)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        exit(0);
                      },
                      child: const Icon(
                        Icons.cancel,
                        size: 35.0,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                      width: 120,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20, top: 20),
                    alignment: Alignment.bottomRight,
                    child: const Text(
                      "Enter Your Details",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              )),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 40, right: 40, top: 70),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: const TextField(
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  hintText: "Full Name",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 40, right: 130, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.green,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 40, right: 240, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: const TextField(
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.green,
                  ),
                  hintText: "Age",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                  left: 40, right: 40, top: 20, bottom: 10),
              padding: const EdgeInsets.only(left: 5, right: 5),
              height: 54,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.grey[200]),
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text("Image"),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 40, right: 40, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white10,
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: const Text(
                  "            Enter            ",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
