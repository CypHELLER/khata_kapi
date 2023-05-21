import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khatakapi/Dashbord/settings.dart';
import 'package:khatakapi/Dashbord/transactions.dart';
import '../Sales/sales.dart';
import 'customers.dart';
import 'floatingbuttonadd.dart';
import 'inventory.dart';
import 'reminders.dart';
import 'suppliers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();

  Future<void> _fetchData() async {
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc('details');

    final snapshot = await userDoc.get();

    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>;
      setState(() {
        _nameController.text = userData['name'] ?? '';
      });
      // Print the fetched data for debugging
      print('Fetched Profile Data:');
      print('Name: ${_nameController.text}');
    } else {
      print('Profile data does not exist');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();

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
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 148, 121, 163),
              ),
              accountName: Text(
                _nameController.text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              accountEmail: Text(
                _auth.currentUser?.phoneNumber ?? 'phone',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 36,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            ListTile(
              iconColor: const Color.fromARGB(255, 148, 121, 163),
              leading: const Icon(
                Icons.inventory_2,
              ),
              title: const Text(
                'Inventory',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Inventory(),
                  ),
                );
              },
            ),
            ListTile(
              iconColor: const Color.fromARGB(255, 148, 121, 163),
              leading: const Icon(
                Icons.bolt,
              ),
              title: const Text(
                'Quick Sales',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SalesItem(),
                  ),
                );
              },
            ),
            ListTile(
              iconColor: const Color.fromARGB(255, 148, 121, 163),
              leading: const Icon(
                Icons.copy,
              ),
              title: const Text(
                'Transactions',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Transactions(),
                  ),
                );
              },
            ),
            ListTile(
              iconColor: const Color.fromARGB(255, 148, 121, 163),
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
                    builder: (context) => const SettingsPage(),
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
              height: 800,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
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
                                backgroundColor: Colors.green.shade600,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Customers(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.person, color: Colors.white),

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
                                // ignore: deprecated_member_use
                                primary: Colors.green.shade600,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Suppliers(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.person, color: Colors.white),

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
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: 1000,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 20, right: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 75,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            children: const [
                                              SizedBox(height: 10),
                                              Text(
                                                "Recent Transaction",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Details",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
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
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
