import 'package:flutter/material.dart';

import 'package:recipe_generator/chat.dart';
import 'package:recipe_generator/recipe_service.dart';
import 'constants.dart';
import 'package:recipe_generator/views/recipeDetail.dart';

class InspirationApp extends StatefulWidget {
  @override
  _InspirationAppState createState() => _InspirationAppState();
}

class _InspirationAppState extends State<InspirationApp> {
  late Future<String> futureRecipeText;
  String regularRecipeText = "";

  Color _color = Colors.deepPurple;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(250.0);

  @override
  void initState() {
    super.initState();
    futureRecipeText = fetchReliableRecipe();
  }

  @override
  Widget build(BuildContext context) {

    Dialog errorDialog = Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: Constants.padding,
                  top: Constants.avatarRadius + Constants.padding,
                  right: Constants.padding,
                  bottom: Constants.padding),
              margin: EdgeInsets.only(top: Constants.avatarRadius),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.padding),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Hooray! 🎉\nRecipe Found 🥳",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: FutureBuilder<String>(
                      future: futureRecipeText,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          regularRecipeText = snapshot.data!;
                          return Text(
                              snapshot.data!,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return RecipeDetail(recipeTitle: regularRecipeText);
                            }));
                          },
                          child: Text(
                            "Recipe",
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                    Spacer()
                  ]),
                  Row(children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            // Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ChatPage();
                            }));
                          },
                          child: Text(
                            "Assistant",
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                  ])
                ],
              ),
            ),
            Positioned(
              left: Constants.padding,
              right: Constants.padding,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: Constants.avatarRadius,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Constants.avatarRadius)),
                    child: Image.asset("spaghetti.jpg")),
              ),
            ),
          ],
        ));

    getRecipeAndShowDialog() {
      setState(() {
        futureRecipeText = fetchReliableRecipe();
      });
      showDialog(
          context: context,
          builder: (BuildContext context) => errorDialog);
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
            'Feeling\nhungry\n🍔🍟',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
          ),
          onPressed: getRecipeAndShowDialog,
        )));
  }
}
