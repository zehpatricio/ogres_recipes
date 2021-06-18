import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/recipe.dart';
import 'dart:convert';

class RecipeProvider with ChangeNotifier {
  static const urlStr = 'http://192.168.0.106:5000/';
  static final url = Uri.parse(urlStr);

  static Future getRecipes() async {
    return await http.get(url);
  }

  static Future addRecipe(Recipe recipe) async {
    return http.post(
      url,
      body: _encodeBody(recipe),
      headers: {"Content-Type": "application/json"},
    );
  }

  static Future updateRecipe(Recipe recipe) async {
    return http.put(
      url,
      body: _encodeBody(recipe),
      headers: {"Content-Type": "application/json"},
    );
  }

  static Future deleteRecipe(Recipe recipe) async {
    return http.delete(
      Uri.parse(urlStr + recipe.id.toString()),
      headers: {"Content-Type": "application/json"},
    );
  }

  static _encodeBody(Recipe recipe) {
    return json.encode({
      if (recipe.id != null) 'id': recipe.id,
      'title': recipe.title,
      if (recipe.description != null) 'description': recipe.description,
      if (recipe.ingredients != null)
        'ingredients': recipe.ingredients!.join('-'),
      if (recipe.howToDo != null) 'howToDo': recipe.howToDo!.join('-'),
      if (recipe.imgUrl != null) 'imgUrl': recipe.imgUrl,
      if (recipe.rate != null) 'rate': recipe.rate,
      if (recipe.timeToCook != null) 'timeToCook': recipe.timeToCook,
    });
  }
}
