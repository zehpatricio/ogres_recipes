import 'package:flutter/material.dart';

import 'package:myapp/models/recipe.dart';
import '../utils.dart';
import 'misc.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;

  // ignore: use_key_in_widget_constructors
  const RecipeDetailsScreen(this.recipe);

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  List<bool> _exp = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      CustomSliverAppBar(widget.recipe.title, 200, widget.recipe.imgUrl),
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
                    child: (widget.recipe.description != null)
                        ? Text(
                            widget.recipe.description!,
                            style: const TextStyle(fontSize: 16),
                          )
                        : Container(),
                  ),
                  if (widget.recipe.rate != null ||
                      widget.recipe.timeToCook != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (widget.recipe.timeToCook != null)
                          TextWithIcon(
                            formatDuration(widget.recipe.timeToCook!),
                            Icons.access_alarm,
                            color: Colors.grey,
                            textSize: 16,
                          ),
                        const SizedBox(height: 6),
                        if (widget.recipe.rate != null)
                          TextWithIcon(
                            '${widget.recipe.rate!}',
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
              ExpansionPanelList(
                  elevation: 0,
                  animationDuration: const Duration(seconds: 2),
                  dividerColor: Colors.transparent,
                  expandedHeaderPadding: EdgeInsets.zero,
                  children: [
                    if (widget.recipe.ingredients != null)
                      createExpansionItemState(
                        "Ingredientes",
                        _exp[0],
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.recipe.ingredients!
                                .asMap()
                                .entries
                                .map((e) => Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Text(e.value)))
                                .toList(),
                          ),
                        ),
                      ),
                    if (widget.recipe.howToDo != null)
                      createExpansionItemState(
                        "Modo de preparo",
                        _exp[1],
                        Column(
                          children: widget.recipe.howToDo!
                              .asMap()
                              .entries
                              .map((e) => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: RecipeStep(
                                      (e.key + 1).toString(), e.value)))
                              .toList(),
                        ),
                      ),
                  ],
                  expansionCallback: (i, isOpen) =>
                      setState(() => _exp[i] = !_exp[i])),
            ],
          ),
        ),
      ),
    ]));
  }
}
