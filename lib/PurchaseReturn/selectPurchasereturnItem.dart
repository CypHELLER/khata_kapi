import 'package:flutter/material.dart';

class SelectPurchasereturnItem extends StatefulWidget {
  const SelectPurchasereturnItem({super.key});

  @override
  State<SelectPurchasereturnItem> createState() => _SelectPurchasereturnItemState();
}

class _SelectPurchasereturnItemState extends State<SelectPurchasereturnItem> {
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
              Icons.search,
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
                "Select Item",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
