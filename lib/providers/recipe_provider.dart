import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/recipe.dart';
import 'dart:convert';

class RecipeProvider with ChangeNotifier {
  static final url = Uri.parse('http://192.168.0.106:5000/v1/recipe');

  static Future getRecipes() async {
    return await http.get(url);
  }

  static Future addRecipe(Recipe recipe) async {
    return http.post(
      url,
      body: json.encode({
        'title': recipe.title,
        if (recipe.description != null) 'description': recipe.description,
        if (recipe.ingredients != null)
          'ingredients': recipe.ingredients!.join('-'),
        if (recipe.howToDo != null) 'howToDo': recipe.howToDo!.join('-'),
        if (recipe.imgUrl != null) 'imgUrl': recipe.imgUrl,
        if (recipe.rate != null) 'rate': recipe.rate,
        if (recipe.timeToCook != null) 'timeToCook': recipe.timeToCook,
      }),
      headers: {"Content-Type": "application/json"},
    );
  }
}
