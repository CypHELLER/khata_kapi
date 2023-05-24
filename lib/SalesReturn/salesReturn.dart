import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../Dashbord/home.dart';
import '../Dashbord/selectItem.dart';

const List<String> billType = <String>[
  "Select Bill Type",
  "Cash Sale",
  "Credit"
];

class SalesReturn extends StatefulWidget {
  const SalesReturn({super.key});

  @override
  State<SalesReturn> createState() => SalesReturnState();
}

class SalesReturnState extends State<SalesReturn> {
  String uID = "";
  String dropdownvalue = billType.first;
  final TextEditingController billNoController = TextEditingController();
  final TextEditingController _billTypeController = TextEditingController();
  final TextEditingController _totalBillController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  var quantity;
  @override
  void dispose() {
    _quantityController.removeListener(updateTotalBill);
    _rateController.removeListener(updateTotalBill);
    _discountController.removeListener(updateTotalBill);
    super.dispose();
  }

  void updateTotalBill() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final rate = int.tryParse(_rateController.text) ?? 0;
    final discount = int.tryParse(_discountController.text) ?? 0;

    final totalBill = (rate * quantity) - discount;
    _totalBillController.text = totalBill.toString();
  }

  void addToBill() {
    updateTotalBill();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() {
    uID = (FirebaseAuth.instance.currentUser!.phoneNumber).toString();
    print(uID);
  }

  Future createBill() async {
    try {
      final docUser =
          FirebaseFirestore.instance.collection("transactions").doc(uID);
      await docUser.update({
        "salesReturn": FieldValue.arrayUnion([
          {
            "quantity": int.parse(_quantityController.text),
            "rate": int.parse(_rateController.text),
            "discount": int.parse(_discountController.text),
            "totalBill": int.parse(_totalBillController.text),
            "billType": _billTypeController.text,
            "date": _dateController.text,
            "remarks": _remarksController.text,
            "billNo": billNoController.text,
          }
        ]),
      }).then(
        (value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        ),
      );

      print('User added successfully!');
    } on FirebaseException catch (e) {
      if (e.code == "not-found") {
        await FirebaseFirestore.instance
            .collection("transactions")
            .doc(uID)
            .set({
          "salesReturn": FieldValue.arrayUnion([
            {
              "quantity": int.parse(_quantityController.text),
              "rate": int.parse(_rateController.text),
              "discount": int.parse(_discountController.text),
              "totalBill": int.parse(_totalBillController.text),
              "billType": _billTypeController.text,
              "date": _dateController.text,
              "remarks": _remarksController.text,
              "billNo": billNoController.text,
            }
          ]),
        }).then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          ),
        );
      }
      print('Error adding user: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
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
          "Sales Return Bill",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
            const SizedBox(
              height: 30,
            ),
            textFieldMethod("Bill No.", billNoController),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 35.0, right: 16),
              child: GestureDetector(
                child: TextField(
                    controller: _dateController,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    cursorColor: Colors.blue, // Customize the cursor color
                    decoration: InputDecoration(
                      labelText: "Date",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 16.0), // Adjust the content padding
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
                    ),
                    readOnly: true,
                    onTap: () => {
                          _selectDate(context),
                        }),
              ),
            ),
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
                        _billTypeController.text = value;
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
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Add Item'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectItem(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.inventory_rounded,
                                    color: Colors.white),
                                label: const Text(
                                  "Select Item",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _quantityController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                cursorColor:
                                    Colors.blue, // Customize the cursor color
                                decoration: InputDecoration(
                                  labelText: 'Quantity',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal:
                                          16.0), // Adjust the content padding
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _rateController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                cursorColor:
                                    Colors.blue, // Customize the cursor color
                                decoration: InputDecoration(
                                  labelText: 'Rate Rs..',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal:
                                          16.0), // Adjust the content padding
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _discountController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                cursorColor:
                                    Colors.blue, // Customize the cursor color
                                decoration: InputDecoration(
                                  labelText: 'Discount Rs.',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal:
                                          16.0), // Adjust the content padding
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: addToBill,
                            child: const Text('Add'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    },
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
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 35.0, right: 16),
              child: TextField(
                controller: _totalBillController,
                enabled: false,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                cursorColor: Colors.blue, // Customize the cursor color
                decoration: InputDecoration(
                  labelText: 'Total Bill Rs.',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0), // Adjust the content padding
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
                ),
              ),
            ),
            textFieldMethod("Remarks", _remarksController),
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
                        backgroundColor: Colors.red,
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
                        backgroundColor: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      if (_totalBillController.text.isNotEmpty &&
                          _billTypeController.text.isNotEmpty &&
                          _dateController.text.isNotEmpty) {
                        createBill();
                        _updateData();
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Field Empty'),
                              content:
                                  const Text('Please fill all the fields.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
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

  Padding textFieldMethod(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 35.0, right: 16),
      child: TextField(
        controller: controller,
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
        ),
      ),
    );
  }

// Function to update the quantity based on a matching name
  Future<void> _updateData() async {
    try {
      // Retrieve the document from Firestore
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('items').doc(uID).get();

      if (snapshot.exists) {
        // Get the array field value from the document
        List<dynamic> items = snapshot.get('items');

        // Find the index of the item with the matching name
        int index = items.indexWhere((item) => item['name'] == 'Potato');

        if (index != -1) {
          // Update the quantity of the item at the matching index
          items[index]['quantity'] =
              quantity - int.parse(_quantityController.text);

          // Update the document in Firestore
          await FirebaseFirestore.instance
              .collection('items')
              .doc(uID)
              .update({'items': items});

          print('Item quantity updated successfully.');
        } else {
          print('Item with name not found.');
        }
      } else {
        print('Document not found.');
      }
    } catch (e) {
      print('Error updating item quantity: $e');
    }
  }
}
