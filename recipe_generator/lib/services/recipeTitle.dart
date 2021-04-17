import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_generator/services/openAIUtils.dart';

// Create recipes
Future<String> fetchRecipe(String prompt, Object configuration) async {
  var result = await http.post(
    Uri.parse("https://api.openai.com/v1/engines/davinci/completions"),
    headers: {
      "Authorization": "Bearer $OPENAI_KEY",
      "Accept": "application/json",
      "Content-Type": "application/json",
    },
    body: jsonEncode(configuration)
  );
  /// Decode the body and select the first choice
  var body = jsonDecode(result.body);
  var text = body["choices"][0]["text"];
  return text;
}

Future<String> fetchReliableRecipe() async {
  String prompt = "Write a list of totally different recipes:\n\n"
      "1. Lemon Chicken with Asparagus\n"
      "2."
  ;
  Object configuration = {
    "prompt": prompt,
    "max_tokens": 16,
    "temperature": 0.7,
    "top_p": 0.5,
    "stop": "\n",
  };
  return fetchRecipe(prompt, configuration);
}

// Find existing recipes
Future<List> searchRecipe(String prompt, Object configuration) async {
  var result = await http.post(
      Uri.parse("https://api.openai.com/v1/engines/ada/search"),
      headers: {
        "Authorization": "Bearer $OPENAI_KEY",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode(configuration)
  );
  /// Decode the body and select the first choice
  var body = jsonDecode(result.body);
  var recipe_list = body["data"];
  var title_list = [];
  for (var i=0; i<recipe_list.length; i++) {
    var text = recipe_list[i]["text"];
    var titleIdx = text.indexOf('\n');
    var title = text.substring(3, titleIdx);
    title = "${title[0].toUpperCase()}${title.substring(1).toLowerCase()}";
    var recipe = text.substring(titleIdx+1);
    title_list.add(title);
  }
  return title_list;
}

Future<List> searchRecipeWithInput(String query) async {
  String prompt = query;
  Object configuration = {
    "search_model": "ada",
    "query": prompt,
    //max_rerank=50,
    "file": OPENAI_FILE_ID
  };
  return searchRecipe(prompt, configuration);
}