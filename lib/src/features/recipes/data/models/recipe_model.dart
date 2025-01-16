import 'package:recipe_book/src/features/recipes/domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    required String name,
    required String author,
    required String imageLink,
    required List<String> recipeSteps,
  }) : super(
          name: name,
          author: author,
          imageLink: imageLink,
          recipeSteps: recipeSteps,
        );

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      name: json['name'],
      author: json['author'],
      imageLink: json['image_link'],
      recipeSteps: List<String>.from(json['recipe'] as List),
    );
  }

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
