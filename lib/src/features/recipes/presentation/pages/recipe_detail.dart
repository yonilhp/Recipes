import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget {
  final String RecipeName;
  const RecipeDetail({super.key, required this.RecipeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(RecipeName),
      backgroundColor: Colors.orange,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ));
  }
}
