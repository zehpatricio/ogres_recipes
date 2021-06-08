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
      description: 'A lasanha é um prato muito amado e superfácil de ser feito',
      imgUrl: 'https://img.cybercook.com.br/receitas/731/lasanha-3.jpeg',
      rate: 4,
      timeToCook: const Duration(hours: 5, minutes: 30),
      ingredients: [
        '500g de massa de lasanha',
        '500g de carne moída',
        '2 caixas de creme de leite',
        '3 colheres de manteiga',
        '3 colheres de farinha de trigo',
        '500g de presunto',
        '500g de mussarela',
        'Sal a gosto',
        '2 copos de leite',
        '1 cebola ralada',
        '3 colheres de óleo',
        '1 caixa de molho de tomate',
        '3 dentes de alho amassados',
        '1 pacote de queijo ralado',
      ],
      howToDo: [
        'Cozinhe a massa segundo as orientações do fabricante, despeje em um refratário com água gelada para não grudar e reserve.',
        'Refogue o alho, a cebola, a carne moída, o molho de tomate, deixe cozinhar por 3 minutos e reserve.',
        'Despeje o leite aos poucos e continue mexendo.',
        'Por último, coloque o creme de leite, mexa por 1 minuto e desligue o fogo.',
        'Despeje uma parte do molho à bolonhesa em um refratário, a metade da massa, a metade do presunto, a metade da mussarela, todo o molho branco e o restante da massa.',
        'Repita as camadas até a borda do recipiente.',
        'Finalize com o queijo ralado e leve ao forno alto (220° C), preaquecido, por cerca de 20 minutos.',
      ]),
];
