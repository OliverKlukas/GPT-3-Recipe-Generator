import 'package:flutter/material.dart';
import 'package:recipe_generator/services/fullRecipe.dart';
import 'package:recipe_generator/utils/mixins.dart';

class RecipeDetailApp extends StatefulWidget {
  String recipeTitle;

  RecipeDetailApp({Key? key, required this.recipeTitle}) : super(key: key);

  @override
  _RecipeDetailAppState createState() => _RecipeDetailAppState();
}

class _RecipeDetailAppState extends State<RecipeDetailApp> {

  late Future<String> futureFullRecipe;

  @override
  void initState() {
    super.initState();
    futureFullRecipe = fetchFullRecipeByName(widget.recipeTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// The top app bar with title
        appBar: AppBar(
          title: Text(widget.recipeTitle),
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
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ]
            ),
            Row (
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FutureBuilder<String>(
                          future: futureFullRecipe,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              String fullText = snapshot.data!;
                              List<String> response = parseIngredientsAndDirections(fullText);
                              return Text(
                                response[0],
                                style: TextStyle(fontSize: 16),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            // By default, show a loading spinner.
                            return CircularProgressIndicator();
                          },
                        )
                      ]
                  ),
                ),
              ]
            ),
            Divider(),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Directions",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ]
            ),
            Column(
              children: [
                FutureBuilder<String>(
                  future: futureFullRecipe,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String fullText = snapshot.data!;
                      List<String> response = parseIngredientsAndDirections(fullText);
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          response[1],
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                )
              ],
            ),
          ]),
        ));
  }
}
