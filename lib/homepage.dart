import 'package:flutter/material.dart';
import 'package:recipe_suggestion/navigationBar.dart';
//import 'package:recipe_suggestion/shop_list.dart';
//import 'package:recipe_suggestion/suggestion_recipe.dart';
//import 'homepage_controller.dart' as functions;
import 'add_item.dart';
//import 'functions.dart' as functions;

//import 'package:flutter/material.dart';
//import 'add_item_page.dart';
//import 'functions.dart' as functions;

class homepage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<homepage> {
  //-------------------------------------------
   int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  //-------------------------------------------
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> expiringSoonItems = items.where((item) {
      if (item['expiryDate'] == null) return false;
      DateTime expiryDate = item['expiryDate'];
      DateTime now = DateTime.now();
      return expiryDate.isAfter(now) && expiryDate.isBefore(now.add(Duration(days: 3)));
    }).toList();

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
              child: expiringSoonItems.isEmpty
                  ? Center(child: Text('No expired food yet'))
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: expiringSoonItems.map((item) => ExpiringItemCard(itemName: item['name'], expiryDate: '${item['expiryDate'].day}/${item['expiryDate'].month}/${item['expiryDate'].year}')).toList(),
                    ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'List of Food',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            FoodCategoryTabs(),
            Expanded(
              child: items.isEmpty
                  ? Center(child: Text('No item added yet'))
                  : ListView(
                      children: items.map((item) => FoodItemCard(
                            itemName: item['name'],
                            expiryDate: '${item['expiryDate'].day}/${item['expiryDate'].month}/${item['expiryDate'].year}',
                            quantity: item['quantity'].toString(),
                          )).toList(),
                    ),
            ),
          ],
        ),
      ),
      //-------------------------------------------------
      bottomNavigationBar: SharedBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      //------------------------------------------------- 
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
            Text('Expiry: $expiryDate',
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.red,
                )),
          ],
        ),
      ),
    );
  }
}

class FoodCategoryTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoryTab(name: 'All'),
          CategoryTab(name: 'Vegetables'),
          CategoryTab(name: 'Fruits'),
          CategoryTab(name: 'Meat'),
          CategoryTab(name: 'Dairy'),
        ],
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String name;

  CategoryTab({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        label: Text(name),
        backgroundColor: Colors.teal.withOpacity(0.1),
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

List<Map<String, dynamic>> items = [];
