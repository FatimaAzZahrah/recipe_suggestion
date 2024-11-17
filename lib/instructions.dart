import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  final String recipeName;

  Instructions({required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructions'),
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
            Text(
              recipeName,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 152, 216, 190).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.kitchen, color: Colors.black54),
                  SizedBox(height: 8.0),
                  Text('Stove, Knife, Cutting Board, Mixing Bowl'),
                  SizedBox(height: 8.0),
                  Text('Ikan kembung, sweet potato flour, ice cubes, msg, water'),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Manual',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 152, 216, 190).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  BulletPoint(text: 'Combine the ground ingredients with sweet potato flour and wheat flour.'),
                  BulletPoint(text: 'Knead until it does not stick.'),
                  BulletPoint(text: 'When it\'s mixed, shape according to the size you like.'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Recipe',
          //  backgroundColor: Colors.teal,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'SmartStock',
          ),
        ],
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('•', style: TextStyle(fontSize: 16.0)),
        const SizedBox(width: 5.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }
}
