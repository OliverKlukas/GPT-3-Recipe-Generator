import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_generator/services/image_service.dart';
import 'package:recipe_generator/services/recipeTitle.dart';
import 'package:recipe_generator/models/recipeModel.dart';
import 'package:recipe_generator/utils/recipiesList.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class DiscoveryPage extends StatefulWidget {

  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {

  // Editing controller for search
  TextEditingController editingController = TextEditingController();

  // Recipe static dataset
  List<Recipe> allRecipes = [
    Recipe(name: "Spaghetti Bolognese", imageURL: ''),
    Recipe(name: "Pancakes", imageURL: ''),
    Recipe(name: "Indian Curry",imageURL: ''),
    Recipe(name: "Pizza Fungi", imageURL: ''),
    Recipe(name: "Hamburger", imageURL: ''),
    Recipe(name: "Cheese Cake", imageURL: ''),
    Recipe(name: "Spaghetti Bolognese", imageURL: ''),
    Recipe(name: "Pancakes", imageURL: ''),
    Recipe(name: "Indian Curry", imageURL: ''),
    Recipe(name: "Pizza Fungi", imageURL: ''),
    Recipe(name: "Hamburger",  imageURL: ''),
    Recipe(name: "Cheese Cake",  imageURL: ''),
  ];

  // Dynamic recipe list for search
  var dispRecipes = <Recipe>[];

  // Fetch images based on created names
  Future<List<Recipe>> getRecipes() async{
    dispRecipes.forEach((element) async {
      if(element.imageURL == ''){
        element.imageURL = await fetchImageUrl(element.name);
      }
    });
    allRecipes.forEach((element) async {
      if(element.imageURL == ''){
        element.imageURL = await fetchImageUrl(element.name);
      }
    });
    return dispRecipes;
  }

  // Initialize speech
  stt.SpeechToText _speech2txt = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';

  // Initialize recipes
  @override
  void initState() {
    super.initState();
    dispRecipes.addAll(allRecipes);
    _speech2txt = stt.SpeechToText();
  }


  // Speech listener
  void _listen() async {
    if (!_isListening) {
      editingController.text = "";
      bool available = await _speech2txt.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech2txt.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            editingController.text = _text;
            editingController.selection = TextSelection.fromPosition(
                TextPosition(offset: editingController.text.length));
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech2txt.stop();
    }
  }


  // Search functionality
  void filterSearchResults(String query) {
    List<Recipe> dummySearchList = <Recipe>[];
    dummySearchList.addAll(allRecipes);
    if(query.isNotEmpty) {
      List<Recipe> dummyListData = <Recipe>[];
      searchRecipeWithInput(query).then((futureRecipeTitle) {
          setState(() {
            if (futureRecipeTitle is List) {
              for (var i=0; i<futureRecipeTitle.length; i++) {
                dummyListData.add(Recipe(
                    name: futureRecipeTitle[i].toString(), imageURL: ""));
              };
              dispRecipes.clear();
              dispRecipes.addAll(dummyListData);
            }
          });
        });
      return;
    } else {
      setState(() {
        dispRecipes.clear();
        dispRecipes.addAll(allRecipes);
      });
    }
  }

  Widget recipeListWidget() {
    return FutureBuilder<List<Recipe>>(
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.connectionState != ConnectionState.none) {
          List<Recipe> values = snapshot.data!;
          return ListView.builder(
            itemCount: values.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return RecipesList(
                name: values[index].name,
                imageURL: values[index].imageURL,
              );
            },
          );
        }
        return Container();
      },
      future: getRecipes(),
    );
  }

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
            FloatingActionButton(
              onPressed: _listen,
              child: Icon(_isListening ? Icons.mic : Icons.mic_none),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
                controller: editingController,
                onSubmitted: (value) {
                  filterSearchResults(value);
                },
                decoration: InputDecoration(
                  hintText: "What do you want to eat today?",
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
            recipeListWidget(),
          ],
        ),
      ),
    );
  }
}

