import 'package:flutter/material.dart';

class ShopList extends StatefulWidget {
  @override
  _ShopListState createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  List<Map<String, dynamic>> itemsToBuy = [
    {'name': 'Ikan Kembung', 'isSelected': false},
    {'name': 'Sweet Potato Flour', 'isSelected': false},
    {'name': 'Ice Cubes', 'isSelected': false},
  ];

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
            Expanded(
              child: ListView.builder(
                itemCount: itemsToBuy.length,
                itemBuilder: (context, index) {
                  final item = itemsToBuy[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CheckboxListTile(
                      title: Text(item['name']),
                      value: item['isSelected'],
                      onChanged: (bool? value) {
                        setState(() {
                          item['isSelected'] = value;
                        });
                      },
                      secondary: Icon(
                        Icons.local_dining,
                        color: Colors.teal,
                      ),
                    ),
                  );
                },
              ),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Recipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'SmartStock',
          ),
        ],
      ),
    );
  }

  void _showAddItemDialog() {
    String newItemName = '';
    String selectedCategory = 'Vegetables';
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
              onPressed: () {
                if (newItemName.isNotEmpty) {
                  setState(() {
                    itemsToBuy.add({'name': newItemName, 'category': selectedCategory, 'isSelected': false});
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
