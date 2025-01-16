class Recipe {
  final String name;
  final String author;
  final String imageLink;
  final List<String> recipeSteps;

  Recipe({
    required this.name,
    required this.author,
    required this.imageLink,
    required this.recipeSteps,
  });

  // Método para crear una instancia de Recipe desde un JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] as String,
      author: json['author'] as String,
      imageLink: json['image_link'] as String,
      recipeSteps: List<String>.from(json['recipe'] as List),
    );
  }

  // Método opcional para convertir la instancia en un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'author': author,
      'image_link': imageLink,
      'recipe': recipeSteps,
    };
  }

  @override
  String toString() {
    return 'Recipe{name: $name, author: $author, image_link: $imageLink, recipe: $recipeSteps}';
  }
}
