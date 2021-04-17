import 'package:flutter/cupertino.dart';

class Recipe{
  String name;
  String imageURL;
  Recipe({required this.name,required this.imageURL});

  bool contains(String query) { // make async if you don't want immediate change
    return name.toLowerCase().contains(query.toLowerCase());
  }
}