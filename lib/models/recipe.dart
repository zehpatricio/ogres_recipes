class Recipe {
  final String title;
  final String? description;
  final String? howToDo;
  final String? imgUrl;
  final int? rate;
  final Duration? timeToCook;

  const Recipe({
    required this.title,
    this.description,
    this.howToDo,
    this.imgUrl,
    this.rate,
    this.timeToCook,
  });
}
