import 'package:flutter/material.dart';
import 'instructions.dart';
import 'homepage.dart';
import 'package:recipe_suggestion/navigationBar.dart';

class CustomItem extends StatefulWidget {
  @override
  _CustomItemState createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {
  List<Map<String, dynamic>> selectedItems = [];

   int _selectedIndex = 1;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggestion Recipe'),
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
              'Please choose your item based on the list of food available',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20.0),
            FoodCategoryTabs(),
            Expanded(
              child: ListView(
                children: items.map((item) {
                  return CheckboxListTile(
                    title: Text(item['name']),
                    subtitle: Text('${item['expiryDate'].day}/${item['expiryDate'].month}/${item['expiryDate'].year}\nQuantity: ${item['quantity']}\n${item['notes']}'),
                    value: selectedItems.contains(item),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedItems.add(item);
                        } else {
                          selectedItems.remove(item);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedItems.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Instructions(recipeName: 'Custom Recipe'),
                      ),
                    );
                  }
                },
                child: const Text('Cook Now', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 1,
      //   selectedItemColor: Colors.teal,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.receipt),
      //       label: 'Recipe',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       label: 'SmartStock',
      //     ),
      //   ],
      // ),
      bottomNavigationBar: SharedBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
