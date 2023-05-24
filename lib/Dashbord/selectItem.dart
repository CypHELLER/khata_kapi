import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectItem extends StatefulWidget {
  const SelectItem({super.key});

  @override
  State<SelectItem> createState() => SelectItemState();
}

class SelectItemState extends State<SelectItem> {
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
          "Inventory",
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
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("items").doc(uid).snapshots(),
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
            if (data.containsKey("items")) {
              List<dynamic> dataList = data["items"];
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
                        subtitle: Text((dataList[index]["quantity"]).toString()),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          var quantity = dataList[index]["quantity"];
                          print(quantity);
                          //Provider.of<QuantityProvider>(context, listen: false).setQuantity(quantity);
                          Navigator.pop(context, quantity);
                          
                        },
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: Text("No Items found"),
          );
        },
      ),
    );
  }
}

// class ItemsPage extends StatelessWidget {
//   final String itemName;
//   final String itemCategory;
//   final String itemCode;
//   final String itemUnit;
//   final int purchasePrice;
//   final String remarks;
//   final int sellingPrice;
//   final int stockQuantity;
//   final String itemLocation;
//   final String date;

//   const ItemsPage({
//     super.key,
//     required this.itemName,
//     required this.itemCategory,
//     required this.itemCode,
//     required this.itemUnit,
//     required this.purchasePrice,
//     required this.remarks,
//     required this.date,
//     required this.sellingPrice,
//     required this.stockQuantity,
//     required this.itemLocation,
//   });
  
//   String? get uid => FirebaseAuth.instance.currentUser!.phoneNumber.toString();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Item Details",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.person,
//               color: Colors.white,
//             ),
//             onPressed: () {},
//           )
//         ],
//         backgroundColor: const Color.fromARGB(255, 148, 121, 163),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: Column(
//             children: [
//               const SizedBox(height: 35),
//               textFieldMethod("Item Category: ", itemCategory, false),
//               textFieldMethod("Item Code: ", itemCode, false),
//               textFieldMethod("Item Location: ", itemLocation, true),
//               textFieldMethod("Item Name: ", itemName, false),
//               textFieldMethod("Item Unit: ", itemUnit, false),
//               textFieldMethod(
//                   "Purchase Price: ", purchasePrice.toString(), false),
//               textFieldMethod(
//                   "Selling Price: ", sellingPrice.toString(), false),
//               textFieldMethod(
//                   "Stock Quantity: ", stockQuantity.toString(), false),
//               textFieldMethod("Remarks: ", remarks, false),
//               const SizedBox(height: 35),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: 150,
//                     height: 45,
//                     child: ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         // ignore: deprecated_member_use
//                         backgroundColor: Colors.red,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(5)),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const Home(),
//                           ),
//                         );
//                       },
//                       icon: const Icon(
//                         Icons.cancel,
//                         color: Colors.white,
//                       ),
//                       label: const Text(
//                         "Clear",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 35),
//                   SizedBox(
//                     width: 150,
//                     height: 45,
//                     child: ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green.shade600,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(5)),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const Home(),
//                           ),
//                         );
//                       },
//                       icon: const Icon(
//                         Icons.save,
//                         color: Colors.white,
//                       ),
//                       label: const Text(
//                         "Save",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }


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

//}
