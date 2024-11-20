import 'package:flutter/material.dart';
import 'package:recipe_suggestion/instructions.dart';
import 'package:recipe_suggestion/navigationBar.dart';
//import 'package:recipe_suggestion/custom_item.dart';

class SuggestionRecipe extends StatefulWidget {
  @override
  _SuggestionRecipeState createState() => _SuggestionRecipeState();

}

class _SuggestionRecipeState extends State <SuggestionRecipe>{

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
              'This suggestion recipe will prioritize items near to expired date',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: [
                  RecipeCard(recipeName: 'Keropok lekor', notes: 'Notes'),
                  RecipeCard(recipeName: 'Shrimp fried rice', notes: 'Notes'),
                  RecipeCard(recipeName: 'Keropok lekor', notes: 'Notes'),
                  RecipeCard(recipeName: 'Shrimp fried rice', notes: 'Notes'),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  print("Custom Item button pressed"); // Debug statement
                  // Handle custom item action
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => CustomItem()),
                  // );
                },
                child: const Text(
                  'Custom Item',
                  style: TextStyle(color: Colors.white),
                ),
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

class RecipeCard extends StatelessWidget {
  final String recipeName;
  final String notes;

  RecipeCard({required this.recipeName, required this.notes});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(Icons.local_dining, color: Colors.teal),
        title: Text(recipeName),
        subtitle: Text(notes),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Instructions(recipeName: recipeName),
              ),
            );
          },
          child: const Text(
            'Cook Now',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
          ),
        ),
      ),
    );
  }
}
