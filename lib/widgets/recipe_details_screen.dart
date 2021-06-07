import 'package:flutter/material.dart';

import 'package:myapp/models/recipe.dart';

class RecipeDetailsScreen extends StatelessWidget {
  Recipe recipe;

  RecipeDetailsScreen(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: Text(recipe.description ?? 'That\'s great!'),
    );
  }
}
