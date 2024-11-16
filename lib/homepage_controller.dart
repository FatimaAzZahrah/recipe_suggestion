// import 'package:recipe_suggestion/HomePage.dart';
// import 'package:recipe_suggestion/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'add_item.dart';

void navigateToAddItemPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddItem()),
  );
}
