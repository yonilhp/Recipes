import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchRecipes extends RecipeEvent {}
