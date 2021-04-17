import 'openAIUtils.dart';

buildPrompt(String userPreference) {
  return "This is a recipe query from a guest to a chef. The guest is looking for a recipe to cook. The guest tells the chef about their cooking preferences.  The cooking preferences are very important. Based on the guest's cooking preferences, the chef tells them 5 titles of recipes to cook.\n###\ncooking preferences: I want to cook an Asian dish with meat in it\n###\nrecipe titles:\n1. Caramelized duck with plum sauce\n2. Thai green curry with pork\n3. Sweet and sour pork\n4. Chinese broccoli with soy sauce\n5. Spicy chicken with green peppers\n###\ncooking preferences: $userPreference\n###\nrecipe titles:\n1. ";
}

Future<String> fetchTitlesByPreference(String userPreference) async {
  String engine = "davinci";
  String prompt = buildPrompt(userPreference);
  Object configuration = {
    "prompt": prompt,
    "max_tokens": 128,
    "temperature": 0.7,
    "top_p": 1.0,
    "frequency_penalty": 0.0,
    "stop": [
      "###",
    ]
  };
  return fetchCompletion(prompt, engine, configuration);
}