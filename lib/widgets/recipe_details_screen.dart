import 'package:flutter/material.dart';

import 'package:myapp/models/recipe.dart';
import '../utils.dart';
import 'misc.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  // ignore: use_key_in_widget_constructors
  const RecipeDetailsScreen(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      CustomSliverAppBar(recipe.title, 200, recipe.imgUrl),
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: (recipe.description != null)
                        ? Text(
                            recipe.description!,
                            style: const TextStyle(fontSize: 16),
                          )
                        : Container(),
                  ),
                  if (recipe.rate != null || recipe.timeToCook != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (recipe.timeToCook != null)
                          TextWithIcon(
                            formatDuration(recipe.timeToCook!),
                            Icons.access_alarm,
                            color: Colors.grey,
                            textSize: 16,
                          ),
                        const SizedBox(height: 6),
                        if (recipe.rate != null)
                          TextWithIcon(
                            '${recipe.rate!}',
                            Icons.star_rate_rounded,
                            color: Colors.orange,
                            textSize: 16,
                          ),
                      ],
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              if (recipe.ingredients != null)
                HeadBody(
                    "Ingredientes",
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recipe.ingredients!
                          .asMap()
                          .entries
                          .map((e) => Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text("* " + e.value)))
                          .toList(),
                    )),
              if (recipe.howToDo != null)
                HeadBody(
                    "Modo de preparo",
                    Column(
                      children: recipe.howToDo!
                          .asMap()
                          .entries
                          .map((e) => Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child:
                                  RecipeStep((e.key + 1).toString(), e.value)))
                          .toList(),
                    ))
            ],
          ),
        ),
      ),
    ]));
  }
}
