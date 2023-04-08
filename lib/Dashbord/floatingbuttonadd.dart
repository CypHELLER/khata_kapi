import 'package:flutter/material.dart';

import '../Expense/expense.dart';
import '../New Item/addNewItem.dart';
import '../New Party/addNewParty.dart';
import '../Purchase/purchase.dart';
import '../PurchaseReturn/purchaseReturn.dart';
import '../Sales/sales.dart';
import '../SalesReturn/salesReturn.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
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
        backgroundColor: const Color.fromARGB(255, 148, 121, 163),
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
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: 250,
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
                              builder: (context) => const NewParty(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.person, color: Colors.white),

                        label: const Text(
                          "Add New Party",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ), //label text
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250,
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
                              builder: (context) => const AddNewItem(),
                            ),
                          );
                        },
                        icon:
                            const Icon(Icons.inventory_2, color: Colors.white),

                        label: const Text(
                          "Add New Item",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ), //label text
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250,
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
                              builder: (context) => const PurchaseItem(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart,
                            color: Colors.white),

                        label: const Text(
                          "Purchase",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ), //label text
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250,
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
                        icon: const Icon(Icons.sell, color: Colors.white),

                        label: const Text(
                          "Sales",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ), //label text
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250,
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
                              builder: (context) => const PurchaseReturn(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart_checkout,
                            color: Colors.white),

                        label: const Text(
                          "Purchase Return",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ), //label text
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250,
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
                              builder: (context) => const SalesReturn(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.outbox, color: Colors.white),

                        label: const Text(
                          "Sales Return",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ), //label text
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250,
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
                              builder: (context) => const Expense(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.currency_rupee,
                            color: Colors.white),

                        label: const Text(
                          "Expences",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ), //label text
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
