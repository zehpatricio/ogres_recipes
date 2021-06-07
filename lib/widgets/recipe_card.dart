import 'package:flutter/material.dart';
import 'package:myapp/models/recipe.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widgets/misc.dart';
import 'package:myapp/widgets/recipe_details_screen.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  RecipeCard(this.recipe);

  void goToDetails(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return RecipeDetailsScreen(recipe);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToDetails(context),
      splashColor: Colors.grey,
      child: Card(
        elevation: 3,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (recipe.description != null)
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: Text(recipe.description!),
                      ),
                    if (recipe.rate != null || recipe.timeToCook != null)
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        child: Row(
                          children: [
                            if (recipe.rate != null)
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: TextWithIcon(
                                  '${recipe.rate!}',
                                  Icons.star_rate_rounded,
                                  color: Colors.orange,
                                ),
                              ),
                            if (recipe.timeToCook != null)
                              TextWithIcon(
                                formatDuration(recipe.timeToCook!),
                                Icons.access_alarm,
                                color: Colors.grey,
                              )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            if (recipe.imgUrl != null)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                child: Image(
                  height: 100,
                  width: 120,
                  fit: BoxFit.fill,
                  image: NetworkImage(recipe.imgUrl!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
