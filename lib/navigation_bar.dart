// import 'package:flutter/material.dart';
// import 'package:recipe_suggestion/add_item.dart';
// import 'homepage.dart';
// //import 'suggestion_recipe.dart';
// //import 'shopping_list.dart';

// class BottomNavigationBar extends StatelessWidget {
//   final int currentIndex;

//   BottomNavigationBar({required this.currentIndex});

//   void _onItemTapped(BuildContext context, int index) {
//     if (index != currentIndex) {
//       Widget nextPage;
//       switch (index) {
//         case 0:
//           nextPage = homepage();
//           nextPage = AddItem();
//           break;
//         case 1:
//           nextPage = suggestionrecipe(); //wait
//           break;
//         case 2:
//           nextPage = Shoppinglist(); //wait
//           break;
//         default:
//           nextPage = homepage();
//       }
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => nextPage),
//         (route) => false,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: (index) => _onItemTapped(context, index),
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.receipt),
//           label: 'Recipe',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.shopping_cart),
//           label: 'SmartStock',
//         ),
//       ],
//       selectedItemColor: Colors.green[800],
//       unselectedItemColor: Colors.grey,
//     );
//   }
// }
