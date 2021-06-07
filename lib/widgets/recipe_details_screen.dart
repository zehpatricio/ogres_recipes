import 'package:flutter/material.dart';

import 'package:myapp/models/recipe.dart';

import '../utils.dart';
import 'misc.dart';

class RecipeDetailsScreen extends StatelessWidget {
  Recipe recipe;
  static const double _expandedHeight = 200.0;

  RecipeDetailsScreen(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        pinned: true,
        expandedHeight: recipe.imgUrl != null ? _expandedHeight : 0,
        flexibleSpace: FlexibleSpaceBar(
            title: Text(recipe.title),
            background: Container(
              foregroundDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.7, 1.0],
                ),
              ),
              child: recipe.imgUrl != null
                  ? Image(
                      height: _expandedHeight,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(recipe.imgUrl!),
                    )
                  : Container(),
            )),
      ),
      SliverToBoxAdapter(
        child: Expanded(
          child: Container(
            height: 1000,
            child: Center(
              child: Text('Hi'),
            ),
          ),
        ),
      ),
    ]));
  }
}
