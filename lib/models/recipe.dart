class Recipe {
  final int? id;
  final String title;
  final String? description;
  final List<String>? ingredients;
  final List<String>? howToDo;
  final String? imgUrl;
  final int? rate;
  final Duration? timeToCook;

  const Recipe({
    required this.title,
    this.id,
    this.description,
    this.ingredients,
    this.howToDo,
    this.imgUrl,
    this.rate,
    this.timeToCook,
  });
}
