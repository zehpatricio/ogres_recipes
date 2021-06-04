import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/recipe.dart';

import 'misc.dart';

class RecipeModalAdd extends StatefulWidget {
  final Function addFuncion;

  RecipeModalAdd(this.addFuncion);

  @override
  State<RecipeModalAdd> createState() => _RecipeModalAddState();
}

class _RecipeModalAddState extends State<RecipeModalAdd> {
  late String title;
  String? description;
  String? howToDo;
  // String? imgUrl;
  // String? rate;
  // String? timeToCook;

  void submit() {
    widget.addFuncion(Recipe(title: title, description: description));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(children: [
        DecoratedTextField(
          'Título',
          (value) => title = value,
        ),
        DecoratedTextField(
          'Descrição',
          (value) => description = value,
        ),
        ElevatedButton(
          onPressed: submit,
          child: const Text('Adicionar'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                }
                return Colors.black;
              },
            ),
          ),
        ),
      ]),
    );
  }
}
