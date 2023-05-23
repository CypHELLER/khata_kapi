import 'package:flutter/material.dart';

class SelectItem extends StatefulWidget {
  @override
  _SelectItemState createState() => _SelectItemState();
}

class _SelectItemState extends State<SelectItem> {
  List<Item> inventoryItems = [
    Item('Item 1', 10.99),
    Item('Item 2', 15.99),
    Item('Item 3', 5.99),
  ];

  List<Item> purchasedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Items",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.inventory,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: const Color.fromARGB(255, 148, 121, 163),
      ),
      body: ListView.builder(
        itemCount: inventoryItems.length,
        itemBuilder: (context, index) {
          final item = inventoryItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                setState(() {
                  purchasedItems.add(item);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle the action to proceed to the purchase bill screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PurchaseBillScreen(purchasedItems),
            ),
          );
        },
        label: Text('View Bill'),
        icon: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class Item {
  final String name;
  final double price;

  Item(this.name, this.price);
}

class PurchaseBillScreen extends StatelessWidget {
  final List<Item> purchasedItems;

  PurchaseBillScreen(this.purchasedItems);

  @override
  Widget build(BuildContext context) {
    double totalAmount = purchasedItems.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase Bill'),
      ),
      body: ListView.builder(
        itemCount: purchasedItems.length,
        itemBuilder: (context, index) {
          final item = purchasedItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
