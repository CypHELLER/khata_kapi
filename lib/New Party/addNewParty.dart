import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Dashbord/home.dart';

const List<String> list1 = <String>["Party Type", "Customer", "Supplier"];
const List<String> list2 = <String>[
  "Transaction Type",
  "To Give",
  "To Receive"
];

class NewParty extends StatefulWidget {
  const NewParty({super.key});

  @override
  State<NewParty> createState() => _NewPartyState();
}

class _NewPartyState extends State<NewParty> {
  String dropdownvalue = list1.first;
  String dropdownvalue1 = list2.first;
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _partyTypeController = TextEditingController();
  final TextEditingController _openingBlcController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _transactionTypeController = TextEditingController();
  @override
  void initState() {
    super.initState();
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
          "Add New Party",
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
        padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            textFieldMethod("Full Name", _nameController),
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 35.0, right: 16),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                cursorColor: Colors.blue, // Customize the cursor color
                decoration: InputDecoration(
                  labelText: 'Phone',
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
            textFieldMethod("Address", _addressController),
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
                        _partyTypeController.text = value;
                      });
                    },
                    items: list1.map<DropdownMenuItem<String>>((String value) {
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
              padding: const EdgeInsets.only(left: 16, bottom: 35.0, right: 16),
              child: TextField(
                controller: _openingBlcController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                cursorColor: Colors.blue, // Customize the cursor color
                decoration: InputDecoration(
                  labelText: 'Opening Balance Rs.',
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
            textFieldMethod("Date", _dateController),
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
                    value: dropdownvalue1,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownvalue1 = value!;
                        _transactionTypeController.text = value;
                      });
                    },
                    items: list2.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
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
                const SizedBox(
                  height: 35,
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
                      String phoneNumber = _phoneController.text;
                      if (phoneNumber.length == 10) {
                        if (_nameController.text.isNotEmpty &&
                            _addressController.text.isNotEmpty &&
                            _phoneController.text.isNotEmpty &&
                            _transactionTypeController.text.isNotEmpty &&
                            _openingBlcController.text.isNotEmpty &&
                            _dateController.text.isNotEmpty) {
                          final user = User(
                            name: _nameController.text,
                            phone: int.parse(_phoneController.text),
                            address: _addressController.text,
                            date: _dateController.text,
                            openingBlc: int.parse(_openingBlcController.text),
                            transactionType: _transactionTypeController.text,
                          );
                          createParty(user);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        } else{
                          showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Field Empty'),
                              content: const
                                  Text('Please fill all the fields.'),
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
                      } else {
                        // Phone number is not valid, show an error message
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Invalid Phone Number'),
                              content: const
                                  Text('Please enter a 10-digit phone number.'),
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

  Future createParty(User party) async {
    try {
      final docUser = FirebaseFirestore.instance
          .collection(_partyTypeController.text)
          .doc();
      _nameController.text = docUser.id;
      final json = party.toJson();
      await docUser.set(json);
      print('User added successfully!');
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}

class User {
  String? id;
  final String name;
  final int phone;
  final String address;
  final String date;
  final String transactionType;
  final int openingBlc;

  User({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.transactionType,
    required this.openingBlc,
    required this.date,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'phone': phone,
        'address': address,
        'date': date,
        'transactionType': transactionType,
        'openingBlc': openingBlc,
        'name': name,
      };
}
