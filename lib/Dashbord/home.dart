import 'dart:io';

import 'package:flutter/material.dart';
import 'package:khatakapi/Dashbord/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Language/language.dart';
import 'editprofile.dart';
import 'floatingbuttonadd.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/images/logo.png",
            width: 80,
          ),
          backgroundColor: const Color.fromARGB(255, 148, 121, 163),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.language,
                  size: 26.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                // <-- SEE HERE
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 148, 121, 163),
                ),
                accountName: Text(
                  "Username",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text(
                  "Phone",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: FlutterLogo(),
              ),
              ListTile(
                iconColor: const Color.fromARGB(255, 148, 121, 163),
                // tileColor:  Color.fromARGB(255, 24, 210, 213),
                // textColor: Colors.white,
                leading: const Icon(
                  Icons.inventory_2,
                ),
                title: const Text(
                  'Inventory',
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                iconColor: const Color.fromARGB(255, 148, 121, 163),
                // tileColor:  Color.fromARGB(255, 24, 210, 213),
                // textColor: Colors.white,
                leading: const Icon(
                  Icons.bolt,
                ),
                title: const Text(
                  'Quick Sales',
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                iconColor: const Color.fromARGB(255, 148, 121, 163),
                // tileColor:  Color.fromARGB(255, 24, 210, 213),
                // textColor: Colors.white,
                leading: const Icon(
                  Icons.copy,
                ),
                title: const Text(
                  'Transactions',
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                iconColor: const Color.fromARGB(255, 148, 121, 163),
                // tileColor:  Color.fromARGB(255, 24, 210, 213),
                // textColor: Colors.white,
                leading: const Icon(
                  Icons.edit,
                ),
                title: const Text(
                  'Edit Profile',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                },
              ),
              ListTile(
                iconColor: const Color.fromARGB(255, 148, 121, 163),
                // tileColor:  Color.fromARGB(255, 24, 210, 213),
                // textColor: Colors.white,
                leading: const Icon(
                  Icons.settings,
                ),
                title: const Text(
                  'Settings',
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                iconColor: const Color.fromARGB(255, 148, 121, 163),
                // tileColor:  Color.fromARGB(255, 24, 210, 213),
                // textColor: Colors.white,
                leading: const Icon(
                  Icons.logout_outlined,
                ),
                title: const Text(
                  'Log Out',
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
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 220,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
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
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 150,
                        height: 45,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green.shade600,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.watch_later,
                              color: Colors.white),

                          label: const Text(
                            "Reminders",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ), //label text
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 35,
                          ),
                          SizedBox(
                            width: 150,
                            height: 45,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green.shade600,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              },
                              icon:
                                  const Icon(Icons.person, color: Colors.white),

                              label: const Text(
                                "Customers",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ), //label text
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            width: 150,
                            height: 45,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green.shade600,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              },
                              icon:
                                  const Icon(Icons.person, color: Colors.white),

                              label: const Text(
                                "Suppliers",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ), //label text
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddButton(),
                ),
              );
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.add, color: Colors.white)));
  }
}
