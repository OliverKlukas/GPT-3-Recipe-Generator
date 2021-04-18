# GPT-3 Makeathon by TUM.AI - Team: Taste the Data
Team - Taste the Data: 
- Carmen Heger <@stedomedo>
- David Stiftl <@stiftlD>
- Christopher Schütz <@cdschtz>
- Oliver Klukas <@OliverKlukas>

## Challenge - Recipe Generator by B/S/H Hausgeräte GmbH
Create an OpenAI solution that creatively can generate recipes by incorporating a list of ingredients or a subset of these, by using cooking methods that are supported by Bosch Cookit and by including the user’s taste and preference.

## Instructions & Hints
Welcome to our Remy Cooking Assistant! To set up our application on your own devices, please follow the following guidance steps:
1. To start the project, please open the recipe_generator in your favourte IDE (we recommend Android Studio or IntelliJ)
2. The first file you are looking for is our lib/main.dart file!
3. Our app is optimized for IOS and Android, so we recommend emulating it on one of the two options
4. For the dynamic image retrieval for recipes and GPT-3 usage you need to add four environment variables when executing main.dart:
  1. OPENAI_FILE_ID = your personal file id of our recipe dataset uploaded to the OPENAI server
  2. OPENAI_KEY = your personal openai GPT-3 access key
  3. UNSPLASH_ACCESS_KEY = your personal unsplash access key
  4. UNSPLASH_SECRET_KEY = your personal unsplash secret key
5. Execute the main.dart file on your favourite emulator and enjoy our cooking companion Remy!
6. Bon Appetit!

# Full Product at a glance
![full_demo 2021-04-18 13_50_21](https://user-images.githubusercontent.com/36952951/115144601-d451f900-a04d-11eb-87c7-657687f690aa.gif)


## Prototype (different features)

https://user-images.githubusercontent.com/36952951/115143491-f5afe680-a047-11eb-9217-4509a1af6bf6.mov

https://user-images.githubusercontent.com/36952951/115143497-fc3e5e00-a047-11eb-9a71-922b7f9602fd.mov

https://user-images.githubusercontent.com/36952951/115144608-e3d14200-a04d-11eb-9d17-e1aecad91bab.mov

## GPT-3 Exemplary Usage

Recipe Title Generation:
<START>
Write a list of totally different recipes:

1. Lemon Chicken with Asparagus
2. 
<END>
 
 
Full Recipe Generation:
<START>
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
<END>
  
