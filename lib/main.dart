import 'package:flutter/material.dart';
import 'package:myapp/widgets/recipes_list_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ogre\'s Cookbook',
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
        home: RecipesListScreen());
  }
}
