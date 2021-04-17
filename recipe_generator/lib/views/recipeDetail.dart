import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget {
  String recipeTitle;

  RecipeDetail({Key? key, required this.recipeTitle}) : super(key: key);

  String _recipeIngredients = """
  1/2 cup of olive oil
  1/2 cup of chopped onion
  1/2 cup of chopped green pepper
  1/2 cup of chopped celery
  1/2 cup of chopped green onion
  1/2 cup of chopped green olives
  1/2 cup of chopped pimiento
  1/2 cup of chopped parsley
  1/4 cup of chopped capers
  1/4 cup of chopped garlic
  1/4 cup of tomato sauce
  1 teaspoon of salt
  1 teaspoon of pepper
  3 cups of rice (long grain)
  3 cups of chicken broth (or water)
  3 cups of cooked chicken (cut into small pieces)
  3 tablespoons of butter (melted)
  """;

  String _recipeDirections = """
  In a large pot, heat the olive oil. Add the onion, green pepper, celery, green onion, olives, pimiento, parsley, capers and garlic. Cook for about 5 minutes. Add the tomato sauce and cook for another 5 minutes. Add the salt and pepper. Add the rice and cook for about 5 minutes. Add the chicken broth and cook for about 15 minutes. Add the chicken and cook for another 10 minutes. Add the butter and serve hot.
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// The top app bar with title
        appBar: AppBar(
          title: Text(recipeTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      fontSize: 16,
                      height: 2,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.wb_sunny, color: Colors.orangeAccent),
                              Text('light'),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.timer, color: Colors.black87),
                              Text('1 hr'),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.people, color: Colors.blueGrey),
                              Text('4-6'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                          "Ingredients",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ]
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(_recipeIngredients),
                    ]
                ),
              ]
            ),
            Divider(),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Directions",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ),
                Text(_recipeDirections)
              ],
            ),
          ]),
        ));
  }
}
