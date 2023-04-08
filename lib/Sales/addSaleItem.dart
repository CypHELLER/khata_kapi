import 'package:flutter/material.dart';
import 'package:khatakapi/Purchase/purchase.dart';
import 'package:khatakapi/Purchase/selectItem.dart';

import 'sales.dart';
import 'selectSaleItem.dart';


class AddSaleItem extends StatefulWidget {
  const AddSaleItem({super.key});

  @override
  State<AddSaleItem> createState() => _AddSaleItemState();
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
class _AddSaleItemState extends State<AddSaleItem> {
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
      child: Center(
        child: ListView(
        children: [
          const Text(
              "Add Item",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
              child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectSaleItem(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.inventory_rounded, color: Colors.white),

                      label: const Text(
                        "Select Item",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ), //label text
                    ),
            ),
            const SizedBox(
              height: 30,
            ),
            text_field("Quantity", ""),
            text_field("Rate Rs.", ""),
            text_field("Discount %", ""),
            text_field("Discount Amount", ""),
            text_field("Remarks", ""),
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
                          builder: (context) => const SalesItem(),
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
                              builder: (context) => const SalesItem(),
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


        ],
      ),
      ),
      ),
    );
    

  }
}