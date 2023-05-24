import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  String uid = "";
  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.phoneNumber.toString();
    print(uid);
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
          "Customers",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: const Color.fromARGB(255, 148, 121, 163),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("party").doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
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
            if (data.containsKey("Customer")) {
              List<dynamic> dataList = data["Customer"];
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
                        top: 10, left: 16, bottom: 10, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        title: Text(dataList[index]["name"]),
                        subtitle: Text(
                            "${dataList[index]["transactionType"]} Rs ${dataList[index]["openingBlc"]}"),
                        //Text(transactionType + " Rs. " + openingBlc.toString()),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          // Navigate to next page and display specific field
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NextPage(
                                name: dataList[index]["name"],
                                transactionType: dataList[index]
                                    ["transactionType"],
                                openingBlc: int.parse(
                                    dataList[index]["openingBlc"].toString()),
                                address: dataList[index]["address"],
                                date: dataList[index]["date"],
                                phone: int.parse(
                                    dataList[index]["phone"].toString()),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: Text("No Customers found"),
          );
        },
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String name;
  final String transactionType;
  final int openingBlc;
  final String address;
  final String date;
  final int phone;

  const NextPage({
    super.key,
    required this.name,
    required this.transactionType,
    required this.openingBlc,
    required this.address,
    required this.date,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Customer Details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: const Color.fromARGB(255, 148, 121, 163),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              const SizedBox(height: 35),
              textFieldMethod("Name", name, true),
              textFieldMethod("Phone", phone.toString(), true),
              textFieldMethod("Address", address, true),
              textFieldMethod(transactionType, openingBlc.toString(), true),
              textFieldMethod("Date", date, false),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    height: 45,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        // ignore: deprecated_member_use
                        backgroundColor: Colors.red,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        deleteData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Clear",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: 150,
                    height: 45,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onPressed: () {
                        updateData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteData() async {
    try {
      String uid=FirebaseAuth.instance.currentUser!.phoneNumber.toString();
      // Get the reference to the Firestore document
      final DocumentReference documentRef =
      FirebaseFirestore.instance.collection('party').doc(uid);
      // Delete the document
      await documentRef.delete();
        await  SnackBar(
            content: const Text('Account Deleted'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.grey[700],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: 280.0,
          );
        
    } catch (e) {
      print('Error deleting data: $e');
    }
  }
Future<void> updateData() async {
  try {
     String uid=FirebaseAuth.instance.currentUser!.phoneNumber.toString();
    // Get the reference to the Firestore document
    final DocumentReference documentRef = FirebaseFirestore.instance.collection('party').doc(uid);

    // Perform the update using the update() method
    await documentRef.update({
      'name': name,
      'phone': phone,
      'address':address,
      'openingBlc':openingBlc,
      
      // Add more fields to update as needed
    });
  } catch (e) {
    print('Error updating data: $e');
  }
}

  Padding textFieldMethod(String labelText, var value, bool editable) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 35.0, right: 16),
      child: TextField(
        controller: TextEditingController(text: value),
        enabled: editable,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        cursorColor: Colors.blue, // Customize the cursor color
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 16.0), // Adjust the content padding
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(8.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.6),
          ),
          suffixIcon: editable
              ? const Icon(Icons.edit, color: Colors.blue)
              : null, // Add an edit icon as suffix if editable
        ),
      ),
    );
  }
}
