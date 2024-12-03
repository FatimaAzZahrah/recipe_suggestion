import 'package:flutter/material.dart';
import 'package:recipe_suggestion/navigationBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShopList extends StatefulWidget {
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  final User? user = FirebaseAuth.instance.currentUser;

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartStock'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'List of Items',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            // Start here
            Expanded(
              child: user != null
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.uid)
                          .collection('shopping_list')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final items = snapshot.data!.docs;
                        if (items.isEmpty) {
                          return Center(child: Text('No items found.'));
                        }
                        return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: CheckboxListTile(
                                title: Text(item['name']),
                                value: item['isSelected'],
                                onChanged: (bool? value) {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user!.uid)
                                      .collection('shopping_list')
                                      .doc(item.id)
                                      .update({'isSelected': value});
                                },
                                secondary: Icon(
                                  Icons.local_dining,
                                  color: Colors.teal,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : Center(child: Text('Please log in to view shopping list.')),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog();
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

  void _showAddItemDialog() {
  String newItemName = '';
  String selectedCategory = 'Vegetables';
  int newItemQuantity = 1; // Quantity field
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {
                newItemName = value;
              },
              decoration: const InputDecoration(hintText: 'Enter item name'),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                newItemQuantity = int.tryParse(value) ?? 1;
              },
              decoration: const InputDecoration(hintText: 'Enter quantity'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (newItemName.isNotEmpty) {
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection('shopping_list')
                      .add({
                    'name': newItemName,
                    'category': selectedCategory,
                    'quantity': newItemQuantity,
                    'isSelected': false,
                    'created_at': FieldValue.serverTimestamp(),
                  });
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}

}
