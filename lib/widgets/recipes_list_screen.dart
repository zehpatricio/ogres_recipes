import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/models/recipe.dart';

import 'package:myapp/providers/recipe_provider.dart';
import 'package:myapp/widgets/recipe_card.dart';
import 'package:myapp/widgets/recipe_add_screen.dart';
import 'package:myapp/widgets/recipe_details_screen.dart';

class RecipesListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecipesListState();
  }
}

class RecipesListState extends State<RecipesListScreen> {
  bool addButtonLeft = false;
  bool _loading = false;
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    updateRecipesList();
  }

  void updateRecipesList() {
    setState(() {
      _loading = true;
    });
    RecipeProvider.getRecipes().then((response) {
      List<Recipe> fetchedRecipes = [];
      final decoded = json.decode(response.body) as List<dynamic>;
      for (var element in decoded) {
        fetchedRecipes.add(
          Recipe(
            id: element['id'],
            title: element['title'],
            description: element['description'],
            imgUrl: element['imgUrl'],
            ingredients: element['ingredients'] != null
                ? (element['ingredients'] as String).split('-')
                : null,
            howToDo: element['howToDo'] != null
                ? (element['howToDo'] as String).split('-')
                : null,
          ),
        );
      }
      setState(() {
        recipes = fetchedRecipes;
        _loading = false;
      });
    });
  }

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
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return RecipeCard(
                      recipes[index],
                      () => goToDetails(ctx, index),
                      (String option) => onMenuSelected(ctx, option, index));
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

  void addButtonPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return RecipeAddScreen(() {
        updateRecipesList();
      });
    }));
  }

  void goToDetails(BuildContext ctx, int index) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return RecipeDetailsScreen(recipes[index]);
    }));
  }

  void onMenuSelected(BuildContext ctx, String option, int index) {
    if (option == RecipeCard.OPT_DETAILS) {
      goToDetails(ctx, index);
    }

    if (option == RecipeCard.OPT_EDIT) {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
        return RecipeAddScreen(() {
          updateRecipesList();
        }, updateRecipe: recipes[index]);
      }));
    }

    if (option == RecipeCard.OPT_DELETE) {
      setState(() {
        recipes.removeAt(index);
      });
    }
  }
}
