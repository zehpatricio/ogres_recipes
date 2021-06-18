import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'package:myapp/models/recipe.dart';
import 'package:myapp/providers/recipe_provider.dart';
import 'package:myapp/utils.dart';

import 'misc.dart';

class RecipeAddScreen extends StatefulWidget {
  final Recipe? updateRecipe;
  final Function onCloseScreen;

  const RecipeAddScreen(this.onCloseScreen, {this.updateRecipe});

  @override
  State<RecipeAddScreen> createState() => _RecipeAddScreenState();
}

class _RecipeAddScreenState extends State<RecipeAddScreen> {
  late String title;
  String? description;
  String? howToDo;
  String? ingredients;
  String? imgUrl;
  int? rate;
  Duration? timeToCook;

  File? _image;
  final picker = ImagePicker();

  var timeToCookController = TextEditingController();
  bool _isLoading = false;

  _RecipeAddScreenState();

  void _submit() {
    setState(() {
      _isLoading = true;
    });
    Future proced;
    if (widget.updateRecipe == null) {
      proced = RecipeProvider.addRecipe(Recipe(
        title: title,
        description: description,
        // timeToCook: timeToCook,
        ingredients: ingredients != null ? ingredients!.split('\n') : null,
        howToDo: howToDo != null ? howToDo!.split('\n') : null,
        // imgUrl: imgUrl,
        // rate: rate),
      ));
    } else {
      proced = RecipeProvider.updateRecipe(Recipe(
        id: widget.updateRecipe!.id,
        title: title,
        description: description,
        // timeToCook: timeToCook,
        ingredients: ingredients != null ? ingredients!.split('\n') : null,
        howToDo: howToDo != null ? howToDo!.split('\n') : null,
        // imgUrl: imgUrl,
        // rate: rate),
      ));
    }

    proced.then((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
      widget.onCloseScreen();
    });
  }

  @override
  void initState() {
    super.initState();
    imgUrl = widget.updateRecipe?.imgUrl;
    rate = widget.updateRecipe?.rate;
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

          timeToCook = Duration(hours: hours, minutes: minutes);
          timeToCookController.text = formatDuration(timeToCook!);
          FocusScope.of(context).requestFocus(FocusNode());
        }).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ogre\'s Cookbook')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(children: [
                  DecoratedTextField(
                    'Título',
                    (value) => title = value,
                    initialValue: widget.updateRecipe?.title,
                  ),
                  DecoratedTextField(
                    'Descrição',
                    (value) => description = value,
                    initialValue: widget.updateRecipe?.description,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTimeToCook(),
                      _buildCameraIcon(),
                    ],
                  ),
                  DecoratedTextField(
                    'Ingredientes',
                    (value) => ingredients = value,
                    initialValue: widget.updateRecipe?.ingredients?.join('\n'),
                  ),
                  DecoratedTextField(
                    'Modo de preparo',
                    (value) => howToDo = value,
                    initialValue: widget.updateRecipe?.howToDo?.join('\n'),
                  ),
                  _buildAddButton(),
                ]),
              ),
            ),
    );
  }

  Future getImage() async {
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  Widget _buildCameraIcon() {
    return GestureDetector(
      onTap: getImage,
      child: Container(
        height: 60,
        width: 80,
        padding: const EdgeInsets.all(5),
        child: _image != null
            ? Image.file(_image!, fit: BoxFit.fill)
            : const Icon(Icons.camera_alt_outlined),
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: _submit,
      child: Text(widget.updateRecipe == null ? 'Adicionar' : 'Atualizar'),
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
    var initial = widget.updateRecipe?.timeToCook;
    return Expanded(
      child: DecoratedTextField(
        'Tempo de preparo',
        (String value) => {
          timeToCook = Duration(
            hours: int.parse(value.split(':')[0]),
            minutes: int.parse(value.split(':')[1]),
          )
        },
        onTap: () => _showPickerNumber(context),
        controller: timeToCookController,
        initialValue: initial != null ? formatDuration(initial) : null,
      ),
    );
  }
}
