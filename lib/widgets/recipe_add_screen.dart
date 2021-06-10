import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:myapp/models/recipe.dart';
import 'package:myapp/utils.dart';

import 'misc.dart';

class RecipeAddScreen extends StatefulWidget {
  final Function _addFuncion;
  final Recipe? updateRecipe;

  const RecipeAddScreen(this._addFuncion, {this.updateRecipe});

  @override
  State<RecipeAddScreen> createState() => _RecipeAddScreenState(updateRecipe);
}

class _RecipeAddScreenState extends State<RecipeAddScreen> {
  late String title;
  String? description;
  String? howToDo;
  String? ingredients;
  // String? imgUrl;
  // String? rate;
  Duration? timeToCook;

  Recipe? updateRecipe;
  var timeToCookController = TextEditingController();

  _RecipeAddScreenState(Recipe? this.updateRecipe);

  void _submit() {
    widget._addFuncion(Recipe(
      title: title,
      description: description,
      timeToCook: timeToCook,
      ingredients: ingredients != null ? ingredients!.split('\n') : null,
      howToDo: howToDo != null ? howToDo!.split('\n') : null,
    ));
    Navigator.of(context).pop();
  }

  _showPickerNumber(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    Picker(
        adapter: NumberPickerAdapter(data: [
          const NumberPickerColumn(begin: 0, end: 12),
          const NumberPickerColumn(begin: 0, end: 59, jump: 5),
        ]),
        delimiter: [
          PickerDelimiter(
            child: Container(
              width: 30.0,
              alignment: Alignment.center,
              child: const Text(':'),
            ),
          )
        ],
        hideHeader: true,
        title: const Text("Tempo de preparo"),
        confirmText: "Ok",
        cancelText: "Cancelar",
        onConfirm: (Picker picker, List value) {
          var hours = picker.getSelectedValues()[0];
          var minutes = picker.getSelectedValues()[1];

          timeToCook = Duration(
            hours: hours,
            minutes: minutes,
          );
          timeToCookController.text = formatDuration(timeToCook!);
          FocusScope.of(context).requestFocus(FocusNode());
        }).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ogre\'s Cookbook')),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(children: [
            DecoratedTextField(
              'Título',
              (value) => title = value,
              initialValue: updateRecipe?.title,
            ),
            DecoratedTextField(
              'Descrição',
              (value) => description = value,
              initialValue: updateRecipe?.description,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTimeToCook(),
                _buildCameraIcon(),
              ],
            ),
            DecoratedTextField('Ingredientes', (value) => ingredients = value),
            DecoratedTextField('Modo de preparo', (value) => howToDo = value),
            _buildAddButton(),
          ]),
        ),
      ),
    );
  }

  Widget _buildCameraIcon() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.camera_alt_outlined),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: _submit,
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
    );
  }

  Widget _buildTimeToCook() {
    return Expanded(
      child: DecoratedTextField(
        'Tempo de preparo',
        (value) => description = value,
        onTap: () => _showPickerNumber(context),
        controller: timeToCookController,
      ),
    );
  }
}
