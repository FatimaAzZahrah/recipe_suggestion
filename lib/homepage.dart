import 'package:flutter/material.dart';
import 'package:recipe_suggestion/navigationBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_item.dart';

class homepage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Robert!'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Expiring soon',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              height: 120.0,
              child: user != null
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .collection('items')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final items = snapshot.data!.docs;
                        final expiringSoonItems = items.where((document) {
                          DateTime? expiryDate = document['expiryDate']?.toDate();
                          if (expiryDate == null) return false;
                          DateTime now = DateTime.now();
                          return expiryDate.isAfter(now) &&
                              expiryDate.isBefore(now.add(Duration(days: 5)));
                        }).toList();
                        if (expiringSoonItems.isEmpty) {
                          return Center(child: Text('No items expiring soon.'));
                        }
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: expiringSoonItems.map((document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return ExpiringItemCard(
                              itemName: data['name'],
                              expiryDate: data['expiryDate'] != null
                                  ? '${data['expiryDate'].toDate().day}/${data['expiryDate'].toDate().month}/${data['expiryDate'].toDate().year}'
                                  : 'No Expiry',
                            );
                          }).toList(),
                        );
                      },
                    )
                  : Center(child: Text('Please log in to view items.')),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'List of Food in the Fridge',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: user != null
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .collection('items')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final items = snapshot.data!.docs;
                        if (items.isEmpty) {
                          return Center(child: Text('No items found.'));
                        }
                        return ListView(
                          children: items.map((document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return FoodItemCard(
                              itemName: data['name'],
                              expiryDate: data['expiryDate'] != null
                                  ? '${data['expiryDate'].toDate().day}/${data['expiryDate'].toDate().month}/${data['expiryDate'].toDate().year}'
                                  : 'No Expiry',
                              quantity: data['quantity'].toString(),
                            );
                          }).toList(),
                        );
                      },
                    )
                  : Center(child: Text('Please log in to view items.')),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItem()),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      bottomNavigationBar: SharedBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ExpiringItemCard extends StatelessWidget {
  final String itemName;
  final String expiryDate;

  ExpiringItemCard({required this.itemName, required this.expiryDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itemName,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              'Expiry: $expiryDate',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final String itemName;
  final String expiryDate;
  final String quantity;

  FoodItemCard({required this.itemName, required this.expiryDate, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(Icons.fastfood, color: Colors.teal),
        title: Text(itemName),
        subtitle: Text('Expiry: $expiryDate\nQuantity: $quantity'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.teal),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
