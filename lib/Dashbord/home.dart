import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khatakapi/Dashbord/purchaseReturns.dart';
import 'package:khatakapi/Dashbord/purchases.dart';
import 'package:khatakapi/Dashbord/recentExpenses.dart';
import 'package:khatakapi/Dashbord/salesReturns.dart';
import 'package:khatakapi/Dashbord/settings.dart';
import '../Sales/sales.dart';
import 'customers.dart';
import 'floatingbuttonadd.dart';
import 'inventory.dart';
import 'suppliers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uID = "";
  final TextEditingController _nameController = TextEditingController();

  Future<void> _fetchData() async {
    uID = _auth.currentUser?.phoneNumber ?? 'phone';
    final userDoc = FirebaseFirestore.instance.collection('users').doc(uID);

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
                Icons.shopping_cart,
              ),
              title: const Text(
                'Purchase',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Purchases(),
                  ),
                );
              },
            ),
            ListTile(
              iconColor: const Color.fromARGB(255, 148, 121, 163),
              leading: const Icon(
                Icons.shopping_cart_checkout,
              ),
              title: const Text(
                'Purchase Return',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PurchaseReturns(),
                  ),
                );
              },
            ),
            ListTile(
              iconColor: const Color.fromARGB(255, 148, 121, 163),
              leading: const Icon(
                Icons.outbox,
              ),
              title: const Text(
                'Sales Return',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SalesReturns(),
                  ),
                );
              },
            ),
            ListTile(
              iconColor: const Color.fromARGB(255, 148, 121, 163),
              leading: const Icon(
                Icons.money,
              ),
              title: const Text(
                'Expenses',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecentExpences(),
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
                    builder: (context) => SettingsPage(
                      isDarkMode: false,
                    ),
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
                    Flexible(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("transactions")
                            .doc(uID)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text("No Data Found"),
                            );
                          }
                          if (snapshot.data!.exists) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            if (data.containsKey("sales")) {
                              List<dynamic> dataList = data["sales"];
                              if (dataList.isEmpty) {
                                return Center(
                                  child: Text("No data"),
                                );
                              }
                              return ListView.builder(
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 16,
                                        bottom: 10,
                                        right: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.green,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: ListTile(
                                        title:
                                            Text(dataList[index]["billType"]),
                                        subtitle: Text(dataList[index]["date"]),
                                        trailing: Text(
                                            " Rs ${dataList[index]["totalBill"]}"),
                                        onTap: () {},
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }
                          return Center(
                            child: Text(""),
                          );
                        },
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
