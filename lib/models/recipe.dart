class Recipe {
  final String title;
  final String? description;
  final String? howToDo;
  final String? imgUrl;
  final int? rate;
  final double? timeToCook;

  Recipe({
    required this.title,
    this.description,
    this.howToDo,
    this.imgUrl,
    this.rate,
    this.timeToCook,
  });
}
