import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Dashbord/home.dart';

const List<String> itemCategory = <String>[
  "Select Item Category",
  "Product",
  "Service"
];
const List<String> itemUnit = <String>[
  "Select Item Unit",
  "KG",
  "Piece",
  "Liter",
  "Box",
  "Dozen",
  "Can",
  "Meter",
  "Pack"
];

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  String dropdownvalue1 = itemCategory.first;
  String dropdownvalue2 = itemUnit.first;

  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _sellpriceController = TextEditingController();
  final TextEditingController _purchaseController = TextEditingController();
  final TextEditingController _stockQuantityTypeController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _itemUnitController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _itemCodeTypeController = TextEditingController();
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
          "Add New Item",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.inventory_2,
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
            textFieldMethod("Item Name", _itemNameController),
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
                        _categoryController.text = value;
                      });
                    },
                    items: itemCategory
                        .map<DropdownMenuItem<String>>((String value) {
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
                    value: dropdownvalue2,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownvalue2 = value!;
                        _itemUnitController.text = value;
                      });
                    },
                    items:
                        itemUnit.map<DropdownMenuItem<String>>((String value) {
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
                controller: _sellpriceController,
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
                  labelText: 'Selling Price Rs.',
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
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 35.0, right: 16),
              child: TextField(
                controller: _purchaseController,
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
                  labelText: 'Purchase Price Rs.',
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
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 35.0, right: 16),
              child: TextField(
                controller: _stockQuantityTypeController,
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
                  labelText: 'Stock Quantity',
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
            textFieldMethod("Item Code", _itemCodeTypeController),
            textFieldMethod("Item Location", _locationController),
            textFieldMethod("Remarks", _remarksController),
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
                      
                       if (_itemNameController.text.isNotEmpty &&
                            _categoryController.text.isNotEmpty &&
                            _itemUnitController.text.isNotEmpty &&
                            _sellpriceController.text.isNotEmpty &&
                            _purchaseController.text.isNotEmpty &&
                            _stockQuantityTypeController.text.isNotEmpty) {
                          final user = User(
                            name: _itemNameController.text,
                            purchasePrice: int.parse(_purchaseController.text),
                            category: _categoryController.text,
                            date: _itemUnitController.text,
                            unit: _categoryController.text,
                            sellingPrice: int.parse(_sellpriceController.text),
                             stockQuantity: int.parse(_stockQuantityTypeController.text),
                            location: _locationController.text,
                            remarks: _remarksController.text,
                            itemCode: _itemCodeTypeController.text,
                          );
                          addItem(user);
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
              height: 35,
              width: 30,
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

  Future addItem(User item) async {
    try {
      final docUser = FirebaseFirestore.instance.collection('').doc();
      //_nameController.text = docUser.id;
      final json = item.toJson();
      await docUser.set(json);
      print('User added successfully!');
    } catch (e) {
      print('Error adding user: $e');
    }
  }
}

class User {
  final String name;
  final String unit;
  final String category;
  final int sellingPrice;
  final int purchasePrice;
  final int stockQuantity;
  final String date;
  final String location;
  final String remarks;
  final String itemCode;

  User({
    required this.itemCode,
    required this.name,
    required this.location,
    required this.unit,
    required this.date,
    required this.sellingPrice,
    required this.purchasePrice,
    required this.stockQuantity,
    required this.remarks,
    required this.category,
  });
  Map<String, dynamic> toJson() => {
        'itemCode': itemCode,
        'name': name,
        'location': location,
        'unit': unit,
        'date': date,
        'sellingPrice': sellingPrice,
        'purchasePrice': purchasePrice,
        'stockQuantity': stockQuantity,
        'remarks': remarks,
        'category': category,
      };
}
