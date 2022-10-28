import 'dart:convert';
import 'package:foodrecipe/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "50", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "9b4af5d194msh706171e4087642ap175b89jsnf03d2ab20266",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List temp = [];

    for (var i in data['feed']) {
      temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(temp);
  }
}
