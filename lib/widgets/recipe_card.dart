import 'package:flutter/material.dart';
import 'package:myapp/models/recipe.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/widgets/misc.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final Function onTap;
  final Function onMenuSelected;
  static const String OPT_DETAILS = 'details';
  static const String OPT_EDIT = 'edit';
  static const String OPT_DELETE = 'delete';

  RecipeCard(this.recipe, this.onTap, this.onMenuSelected);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
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
                    _buildTitle(),
                    if (recipe.description != null) _buildDescription(),
                    if (recipe.rate != null || recipe.timeToCook != null)
                      _buildRateAndTimeToCook(),
                  ],
                ),
              ),
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                if (recipe.imgUrl != null) _buildImage(),
                _buildPopUpMenu(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      recipe.title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      child: Text(recipe.description!),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
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
    );
  }

  Widget _buildRate() {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: TextWithIcon(
        '${recipe.rate!}',
        Icons.star_rate_rounded,
        color: Colors.orange,
      ),
    );
  }

  Widget _buildTimeToCook() {
    return TextWithIcon(formatDuration(recipe.timeToCook!), Icons.access_alarm);
  }

  Widget _buildRateAndTimeToCook() {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          if (recipe.rate != null) _buildRate(),
          if (recipe.timeToCook != null) _buildTimeToCook(),
        ],
      ),
    );
  }

  Widget _buildPopUpMenu() {
    return Container(
      width: 32,
      decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(color: Colors.white, blurRadius: 25, spreadRadius: 5)
      ]),
      child: PopupMenuButton(
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: OPT_DETAILS,
              child: TextWithIcon('Detalhes', Icons.remove_red_eye_outlined,
                  iconLeft: false, spaceBetween: 10),
            ),
            const PopupMenuItem(
              value: OPT_EDIT,
              child: TextWithIcon('Editar', Icons.edit,
                  iconLeft: false, spaceBetween: 10),
            ),
            const PopupMenuItem(
              value: OPT_DELETE,
              child: TextWithIcon('Deletar', Icons.delete,
                  iconLeft: false, spaceBetween: 10),
            )
          ];
        },
        onSelected: (String value) => onMenuSelected(value),
      ),
    );
  }
}
