import 'package:flutter/material.dart';

import '../Dashbord/home.dart';
import 'addSalesreturnItem.dart';

const List<String> billType = <String>[
  "Select Bill Type",
  "Cash Sale",
  "Credit"
];

class SalesReturn extends StatefulWidget {
  const SalesReturn({super.key});

  @override
  State<SalesReturn> createState() => _SalesReturnState();
}

class _SalesReturnState extends State<SalesReturn> {
  String dropdownvalue = billType.first;
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
              Icons.outbox,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: const Color.fromARGB(255, 148, 121, 163),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
        child: ListView(
          children: [
            const Text(
              "Sales Return Bill",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
            ),
            text_field("Bill No.", ""),
            text_field("Date", "year/month/day"),
            Container(
              padding: const EdgeInsets.only(left: 30, bottom: 35.0, right: 30),
              child: DropdownButtonHideUnderline(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 50),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton(
                    value: dropdownvalue,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownvalue = value!;
                      });
                    },
                    items:
                        billType.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
                      Container(
              padding: const EdgeInsets.only(right: 25.0, left: 25.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddSalesreturnItem(),
                    ),
                  );
                },
                icon: const Icon(Icons.inventory, color: Colors.white),

                label: const Text(
                  "Add Item",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ), //label text
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            text_field("Total Bill Rs.", ""),
            text_field("Remarks", ""),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 40, right: 40),
              padding: const EdgeInsets.only(left: 5, right: 5),
              height: 54,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.grey[200]),
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text("Images"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
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
                    icon: const Icon(Icons.cancel, color: Colors.white),

                    label: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ), //label text
                  ),
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
                    icon: const Icon(Icons.save, color: Colors.white),

                    label: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ), //label text
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Padding text_field(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 35.0, right: 30),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}