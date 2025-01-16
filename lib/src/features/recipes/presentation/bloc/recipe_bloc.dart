import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_book/src/features/recipes/data/models/recipe_model.dart';
import 'package:recipe_book/src/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_book/src/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:recipe_book/src/features/recipes/presentation/bloc/recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInitial()) {
    on<FetchRecipes>(_onFetchRecipes);
  }

  Future<void> _onFetchRecipes(
      FetchRecipes event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());
    try {
      final url = Uri.parse('http://10.0.0.0:3001/recipes');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Recipe> recipes = List<Recipe>.from(
            data['recipes'].map((recipe) => RecipeModel.fromJson(recipe)));
        emit(RecipeLoaded(recipes));
      } else {
        emit(RecipeError('Failed to load recipes'));
      }
    } catch (e) {
      emit(RecipeError('Error fetching recipes: $e'));
    }
  }
}
