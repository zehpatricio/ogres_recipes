import 'package:flutter/material.dart';

import 'package:myapp/data/recipes_data.dart';
import 'package:myapp/models/recipe.dart';
import 'package:myapp/widgets/recipe_card.dart';
import 'package:myapp/widgets/recipe_add_screen.dart';

class RecipesListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecipesListState();
  }
}

class RecipesListState extends State<RecipesListScreen> {
  bool addButtonLeft = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ogre\'s Cookbook'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  addButtonLeft = !addButtonLeft;
                });
              },
              icon: const Icon(Icons.compare_arrows)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return RecipeCard(recipes[index]);
          },
          itemCount: recipes.length,
        ),
      ),
      floatingActionButtonLocation: addButtonLeft
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => addButtonPressed(context),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  addButtonPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return RecipeAddScreen((Recipe recipe) {
        setState(() {
          recipes.add(recipe);
        });
      });
    }));
  }
}
