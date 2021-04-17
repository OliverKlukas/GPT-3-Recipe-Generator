import 'package:recipe_generator/services/openAIUtils.dart';

getPromptOneByName(String recipeName) {
  return "Ingredients and steps to cook $recipeName. After the last step, write \"Bon Appetit!\".\n"
    "###\n"
    "Ingredients:"
  ;
}

Future<String> fetchFullRecipeByName(String recipeName) async {
  String engine = "davinci";
  String prompt = getPromptOneByName(recipeName);
  Object configuration = {
    "prompt": prompt,
    "max_tokens": 256,
    "temperature": 0.1,
    "top_p": 1.0,
    "frequency_penalty": 0.2,
    "stop": [
      "###", "Bon Appetit!"
    ]
  };

  return fetchCompletion(prompt, engine, configuration);
}