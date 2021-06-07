import 'package:myapp/models/recipe.dart';

List<Recipe> recipes = [
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
    timeToCook: const Duration(hours: 5, minutes: 30),
  ),
];
