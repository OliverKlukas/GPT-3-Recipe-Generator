import 'package:flutter/material.dart';
import 'package:recipe_generator/services/image_service.dart';

import 'package:recipe_generator/services/recipeTitle.dart';
import 'package:recipe_generator/utils/customDialog.dart';

class InspirationApp extends StatefulWidget {
  @override
  _InspirationAppState createState() => _InspirationAppState();
}

class _InspirationAppState extends State<InspirationApp> {
  late Future<String> futureRecipeText;
  String regularRecipeText = "";
  late Future<String> futureRecipeURL;
  String regularRecipeURL = "";

  Color _color = Colors.deepPurple;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(250.0);

  @override
  void initState() {
    super.initState();
    futureRecipeText = fetchReliableRecipe();
    futureRecipeURL = fetchImageUrl("Hamburger");
  }

  @override
  Widget build(BuildContext context) {

    getRecipeAndShowDialog() {
      setState(() {
        futureRecipeText = fetchReliableRecipe();
        futureRecipeURL = fetchImageUrl("Hamburger");
      });
      showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialogBox(
              futureRecipeText: futureRecipeText,
              regularRecipeText: regularRecipeText,
              futureRecipeURL: futureRecipeURL,
              regularRecipeURL: regularRecipeURL
          ));
    }

    return AnimatedContainer(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: _borderRadius,
        ),
        // Define how long the animation should take.
        duration: Duration(seconds: 1),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.fastOutSlowIn,
        child: Center(
            child: TextButton(
          child: const Text(
            'Feeling\nhungry\nšš',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
          ),
          onPressed: getRecipeAndShowDialog,
        )));
  }
}
