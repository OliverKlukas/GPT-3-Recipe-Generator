import 'package:flutter/material.dart';
import 'package:recipe_generator/recipeModel.dart';
import 'package:recipe_generator/recipiesList.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  List<Recipe> recipes = [
    Recipe(name: "Spaghetti Bolognese", imageURL: "https://img.chefkoch-cdn.de/rezepte/807111184564987/bilder/668266/crop-960x720/spaghetti-bolognese.jpg"),
    Recipe(name: "Pancakes", imageURL: "https://www.einfachbacken.de/sites/einfachbacken.de/files/styles/full_width_tablet_4_3/public/2020-08/american_pancakes.jpg?h=4521fff0&itok=yvzcMTED"),
    Recipe(name: "Indian Curry",imageURL: "https://hips.hearstapps.com/del.h-cdn.co/assets/17/31/1501791674-delish-chicken-curry-horizontal.jpg?crop=1.00xw:0.750xh;0,0.159xh&resize=1200:*"),
    Recipe(name: "Pizza Fungi", imageURL: "https://media.kaufland.com/images/PPIM/AP_Content_1010/std.lang.all/86/19/Asset_3618619.jpg"),
    Recipe(name: "Hamburger",  imageURL: "https://www.kuechengoetter.de/uploads/media/630x630/09/24729-hamburger-zum-selber-bauen.jpg?v=1-0"),
    Recipe(name: "Cheese Cake",  imageURL: "https://www.einfachbacken.de/sites/einfachbacken.de/files/styles/full_width_tablet_4_3/public/2020-03/klassischer_kasekuchen_2.jpg?h=4521fff0&itok=-W9far_5"),
    Recipe(name: "Spaghetti Bolognese", imageURL: "https://img.chefkoch-cdn.de/rezepte/807111184564987/bilder/668266/crop-960x720/spaghetti-bolognese.jpg"),
    Recipe(name: "Pancakes", imageURL: "https://www.einfachbacken.de/sites/einfachbacken.de/files/styles/full_width_tablet_4_3/public/2020-08/american_pancakes.jpg?h=4521fff0&itok=yvzcMTED"),
    Recipe(name: "Indian Curry",imageURL: "https://hips.hearstapps.com/del.h-cdn.co/assets/17/31/1501791674-delish-chicken-curry-horizontal.jpg?crop=1.00xw:0.750xh;0,0.159xh&resize=1200:*"),
    Recipe(name: "Pizza Fungi", imageURL: "https://media.kaufland.com/images/PPIM/AP_Content_1010/std.lang.all/86/19/Asset_3618619.jpg"),
    Recipe(name: "Hamburger",  imageURL: "https://www.kuechengoetter.de/uploads/media/630x630/09/24729-hamburger-zum-selber-bauen.jpg?v=1-0"),
    Recipe(name: "Cheese Cake",  imageURL: "https://www.einfachbacken.de/sites/einfachbacken.de/files/styles/full_width_tablet_4_3/public/2020-03/klassischer_kasekuchen_2.jpg?h=4521fff0&itok=-W9far_5"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Discover Recipes",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: recipes.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return RecipesList(
                  name: recipes[index].name,
                  imageURL: recipes[index].imageURL,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

