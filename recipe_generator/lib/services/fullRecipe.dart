import 'package:recipe_generator/services/openAIUtils.dart';

getPromptOneByName(String recipeName) {
  return
  "Ingredients and instructions to cook a recipe. After the last step, write \"Bon Appetit!\".\n"
  "###\n"
  "Recipe: Veal stock\n"
  "Ingredients:\n"
  "1 tbsp sunflower oil\n750 g veal bones\nask your butcher to chop up into pieces approx. 2 cm in size\nSalt\nBlack peppercorns 1 onion\n1 small carrot\n"
  "1 small piece celeriac\n1 small piece leek 2 tbsp tomato purée\n1 bay leaf\n½ bunch flat-leaf parsley\n"
  "Instructions:\n"
  "1. Add the sunflower oil to the pot and heat for 3 minutes.\n"
  "2.Add the veal bones to the pot and sear uncovered for 20 minutes. Stir several times.\n"
  "3.Season with salt and pepper.\n"
  "4.Cut the onion, carrot, celeriac and leek into pieces approx. 1 cm in size and add to the bones.\n"
  "5.Sear all ingredients for another 3 minutes.\n"
  "6.Add the tomato purée and bay leaf, season with salt and pepper and sear for another 5 minutes.\n"
  "7. Deglaze with 250 ml water and then reduce for 17 minutes.\n"
  "8. In the meantime briefly rinse the parsley and shake dry. Then break off the stalks and add the leaves to the pot.\n"
  "9.Add 750 ml water to the sauce base and leave to stew for 60 minutes.\n"
  "10. Pass the veal stock through a very fine sieve and either re-use straight away or leave to cool down.\n"
  "11.Bon Appetit!\n"
  "###\n"
  "Recipe: Rice pudding with raspberry jelly\n"
  "Ingredients:\n"
  "milk\nsugar\nrice\nvanilla sauce\nraspberry jelly\n"
  "Steps:\n"
  "1. In a saucepan, bring the milk to a boil.\n"
  "2. Add the sugar and rice and stir well.\n"
  "3. Remove from the heat and let cool down for about 10 minutes (don't let it get cold).\n"
  "4. Drain the rice pudding when cooked.\n"
  "5. Add vanilla sauce (or vanilla sugar) to taste, stir in well and serve with raspberry jelly.\n"
  "6. Bon Appetit!\n"
  "###\n"
  "Recipe: $recipeName\n"
      "Ingredients:\n"
  ;


}

Future<String> fetchFullRecipeByName(String recipeName) async {
  String engine = "davinci";
  String prompt = getPromptOneByName(recipeName);
  Object configuration = {
    "prompt": prompt,
    "max_tokens": 256,
    "temperature": 0.4,
    "top_p": 0.8,
    "frequency_penalty": 0.2,
    "stop": [
      "###",
    ]
  };

  return fetchCompletion(prompt, engine, configuration);
}