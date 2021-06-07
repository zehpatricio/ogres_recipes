import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:myapp/models/recipe.dart';
import 'package:myapp/utils.dart';

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
  Duration? timeToCook;
  var timeToCookController = TextEditingController();

  void submit() {
    widget.addFuncion(Recipe(
      title: title,
      description: description,
      timeToCook: timeToCook,
    ));
    Navigator.of(context).pop();
  }

  showPickerNumber(BuildContext context) {
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
        DecoratedTextField(
          'Tempo de preparo',
          (value) => description = value,
          onTap: () => showPickerNumber(context),
          controller: timeToCookController,
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
