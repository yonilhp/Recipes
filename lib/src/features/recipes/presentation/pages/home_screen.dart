import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/src/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_book/src/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:recipe_book/src/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:recipe_book/src/features/recipes/presentation/bloc/recipe_state.dart';
import 'package:recipe_book/src/features/recipes/presentation/pages/recipe_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => RecipeBloc()..add(FetchRecipes()),
        child: BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, state) {
            if (state is RecipeLoading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              );
            } else if (state is RecipeLoaded) {
              return ListView.builder(
                itemCount: state.recipes.length,
                itemBuilder: (context, index) {
                  return _buildRecipeCard(context, state.recipes[index]);
                },
              );
            } else if (state is RecipeError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text('No recipes found'),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          _showBottom(context);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showDialog(
      context: context,
      builder: (contexto) => AlertDialog(
        content: SingleChildScrollView(
          child: RecipeForm(),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, Recipe recipe) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeDetail(RecipeName: recipe.name),
          ));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  height: 125,
                  width: 125,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(recipe.imageLink, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recipe.name,
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 5,
                      width: 100,
                      color: Colors.orange,
                    ),
                    SizedBox(height: 5),
                    Text('By: ${recipe.author}',
                        style:
                            TextStyle(fontSize: 16, fontFamily: 'Quicksand')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final TextEditingController recipeNameController = TextEditingController();
    final TextEditingController authorController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();
    final TextEditingController recipeController = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Recipe',
                style: TextStyle(fontSize: 20, color: Colors.orange),
              ),
              SizedBox(height: 10),
              _buildTextField(
                  controller: recipeNameController,
                  label: 'Recipe Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  }),
              _buildTextField(
                  controller: authorController,
                  label: 'Author',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the author';
                    }
                    return null;
                  }),
              _buildTextField(
                  controller: imageUrlController,
                  label: 'Image URL',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the image URL';
                    }
                    return null;
                  }),
              _buildTextField(
                  maxLines: 2,
                  controller: recipeController,
                  label: 'Recipe',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the recipe';
                    }
                    return null;
                  }),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text('Save Recipe',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.orange,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange, width: 2),
          ),
        ),
        controller: controller,
        validator: validator,
        maxLines: maxLines,
      ),
    );
  }
}
