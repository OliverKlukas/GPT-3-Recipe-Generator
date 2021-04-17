import 'package:recipe_generator/services/openAIUtils.dart';
import 'package:recipe_generator/services/fullRecipe.dart';

getFullAssistantPrompt(String recipeName) async {
    String starterPrompt =
        "The following is a conversation with an AI cooking assistant. "
        "The assistant is polite, helpful, creative, clever, very friendly, and only talks about cooking. "
        "The human is trying to cook the following recipe:$recipeName\n"
        "###\n"
        "Ingredients:\n";

    // This is supposed to generate the intermediate part with the
    // ingredients and the instrucionts.
    // This way, the user can later e.g. ask for the ingredients needed
    // in the recipe.
    String recipeInstructions = "";
    await Future.wait([fetchFullRecipeByName(recipeName)])
        .then((values) => {
      recipeInstructions = values[0]
    });

    String suffix = "\n###\n"
        "Human: Hello, who are you?\n"
        "AI: Hi I am an AI created by OpenAI. Let me help you cook!\n";

    String resultPrompt = starterPrompt + recipeInstructions + suffix;

    // Print to terminal for 'debugging'
    print("Resulting prompt to initiate assistant conversation:\n$resultPrompt");
    return resultPrompt;
}

Future<String> fetchAssistantResponse(String prompt) {
  print("Start fetchAssistantResponse");
  String engine = "davinci";
  Object configuration = {
    "prompt": prompt,
    "max_tokens": 100,
    "temperature": 0.8,
    "top_p": 1.0,
    "best_of": 2,
    "frequency_penalty": 0.3,
    "presence_penalty": 0.6,
    "stop": "\n"
  };
  return fetchCompletion(prompt, engine, configuration);
}
