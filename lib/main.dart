import 'package:flutter/material.dart';
import 'package:myapp/models/recipe.dart';
import 'package:myapp/widgets/recipe_card.dart';
import 'package:myapp/widgets/recipe_modal_add.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final List<Recipe> recipes = [
    Recipe(
      title: 'Hamburguer',
    ),
    Recipe(
      title: 'Beef',
      description: 'Donec egestas purus eu nunc gravida elementum.',
    ),
    Recipe(
      title: 'BBQ',
      imgUrl:
          'https://static.wixstatic.com/media/789c5a_748b4ed0c42e42168610c4a4d237b396~mv2.jpg/v1/fill/w_1000,h_730,al_c,q_90,usm_0.66_1.00_0.01/789c5a_748b4ed0c42e42168610c4a4d237b396~mv2.jpg',
    ),
    Recipe(
      title: 'Duck',
      description: 'Maecenas in ipsum imperdiet, sagittis sapien id, laoreet.',
      imgUrl:
          'https://www.comidaereceitas.com.br/img/sizeswp/1200x675/2012/02/pato_assado_ervas.jpg',
    ),
    Recipe(
      title: 'Lasagna',
      description: 'Donec egestas purus eu nunc gravida elementum.',
      imgUrl: 'https://img.cybercook.com.br/receitas/731/lasanha-3.jpeg',
      rate: 4,
      timeToCook: 5.5,
    ),
  ];

  bool addButtonLeft = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ogre\'s Cookbook',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Ogre\'s Cookbook'),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      addButtonLeft = !addButtonLeft;
                    });
                  },
                  icon: const Icon(Icons.compare_arrows)),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return RecipeCard(recipes[index]);
              },
              itemCount: recipes.length,
            ),
          ),
          floatingActionButtonLocation: addButtonLeft
              ? FloatingActionButtonLocation.startFloat
              : FloatingActionButtonLocation.endFloat,
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => addButtonPressed(context),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ));
  }

  addButtonPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return RecipeModalAdd((Recipe recipe) {
            setState(() {
              recipes.add(recipe);
            });
          });
        });
  }
}
